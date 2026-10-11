"""Validate public content, crawlable pages, links, and the deployment package."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urljoin, urlparse
import argparse
import gzip
import json
import struct
import xml.etree.ElementTree as ET


class Document(HTMLParser):
    def __init__(self, text):
        super().__init__()
        self.links = []
        self.meta = {}
        self.h1 = 0
        self.feed(text)

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == 'h1':
            self.h1 += 1
        for name in ('href', 'src'):
            if name in attrs and tag != 'base':
                self.links.append(attrs[name])
        if tag == 'meta':
            self.meta[attrs.get('property', attrs.get('name', ''))] = attrs.get('content', '')
        if tag == 'img':
            assert 'alt' in attrs, 'An HTML content image lacks alternative text'


def ascii_text(value):
    return value.replace('’', "'").replace('—', '-').replace('–', '-').replace('·', '|')


def luminance(color):
    channels = [int(color[i:i+2], 16) / 255 for i in (0, 2, 4)]
    linear = [x / 12.92 if x <= .04045 else ((x + .055) / 1.055) ** 2.4 for x in channels]
    return sum(x * w for x, w in zip(linear, (.2126, .7152, .0722)))


def main():
    repo = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser()
    parser.add_argument('--root', default=str(repo / 'build/web'))
    root = Path(parser.parse_args().root)
    data = json.loads((repo / 'assets/data/profile.json').read_text())
    canonical = data['canonical']
    prefix = urlparse(canonical).path
    files = list(root.rglob('*.html'))
    assert len(files) == 8, 'Expected the portfolio and seven case-study pages'
    checked = 0
    for path in files:
        relative = str(path.relative_to(root))
        current = canonical + ('' if relative == 'index.html' else relative)
        text = path.read_text()
        doc = Document(text)
        assert doc.h1 == 1, f'{relative}: expected one primary heading'
        assert doc.meta.get('description'), f'{relative}: missing description'
        assert doc.meta.get('og:image') == canonical + 'social-preview.png'
        assert 'application/ld+json' in text
        for link in doc.links + [doc.meta['og:image']]:
            resolved = urlparse(urljoin(current, link))
            if resolved.scheme == 'mailto':
                assert resolved.path == data['email']
                continue
            if resolved.netloc != urlparse(canonical).netloc:
                assert resolved.netloc in {'www.linkedin.com', 'github.com', 'apps.apple.com', 'play.google.com'}
                continue
            assert resolved.path.startswith(prefix), f'Unexpected local destination: {link}'
            local = root / resolved.path.removeprefix(prefix)
            if resolved.path.endswith('/'):
                local /= 'index.html'
            assert local.is_file(), f'{relative}: broken local asset/link {link}'
            checked += 1
    locs = [x.text for x in ET.parse(root / 'sitemap.xml').iter('{http://www.sitemaps.org/schemas/sitemap/0.9}loc')]
    expected = [canonical] + [canonical + f"case-studies/{p['slug']}/" for p in data['projects']]
    assert set(locs) == set(expected)
    assert canonical + 'sitemap.xml' in (root / 'robots.txt').read_text()
    assert f'<base href="{prefix}">' in (root / 'index.html').read_text()
    resume = root / 'resume/Mahmoud-Shady-Resume.pdf'
    assert resume.read_bytes().startswith(b'%PDF') and resume.stat().st_size < 5_000_000
    resume_text = (root / 'resume/Mahmoud-Shady-Resume.txt').read_text()
    for experience in data['experience']:
        assert ascii_text(experience['company']) in resume_text
        assert ascii_text(experience['period']) in resume_text
    assert "Bachelor's degree" in resume_text and 'September 2023' in resume_text
    assert 'approximately three months' in resume_text and 'not released' in resume_text
    assert struct.unpack('>II', (root / 'social-preview.png').read_bytes()[16:24]) == (1200, 630)
    js = (root / 'main.dart.js').read_bytes()
    assert len(js) < 4_000_000, 'Application JS exceeded the 4 MB release budget'
    assert 'canvasKitBaseUrl' in (root / 'flutter_bootstrap.js').read_text()
    ratios = {}
    for label, foreground in [('primary', '222322'), ('secondary', '62645f'), ('accent', '694d91')]:
        a, b = sorted([luminance(foreground), luminance('f6f4ef')])
        ratio = (b + .05) / (a + .05)
        assert ratio >= 4.5, f'{label} text fails minimum normal-text contrast'
        ratios[label] = round(ratio, 2)
    print(json.dumps({'html_pages': len(files), 'local_links_and_assets_checked': checked,
                      'sitemap_urls': len(locs), 'resume_bytes': resume.stat().st_size,
                      'application_js_bytes': len(js), 'application_js_gzip_bytes': len(gzip.compress(js)),
                      'text_contrast_ratios': ratios, 'status': 'passed'}, indent=2))


if __name__ == '__main__':
    main()
