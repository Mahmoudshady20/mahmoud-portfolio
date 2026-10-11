from pathlib import Path
import json,html,re
from reportlab.platypus import SimpleDocTemplate,Paragraph,Spacer,PageBreak
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.enums import TA_LEFT
from reportlab.lib import colors
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
font_candidates=[(Path('/System/Library/Fonts/Supplemental/Arial.ttf'),Path('/System/Library/Fonts/Supplemental/Arial Bold.ttf')),(Path('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'),Path('/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'))]
font_pair=next((pair for pair in font_candidates if all(x.exists() for x in pair)),None)
if font_pair:
 pdfmetrics.registerFont(TTFont('ResumeSans',str(font_pair[0])))
 pdfmetrics.registerFont(TTFont('ResumeSansBold',str(font_pair[1])))
else:
 raise RuntimeError('Install Arial or DejaVu Sans before generating the resume; fonts are embedded for reliable rendering.')
from PIL import Image,ImageDraw,ImageFont

R=Path(__file__).resolve().parents[1];data=json.loads((R/'assets/data/profile.json').read_text());base=data['canonical'];esc=html.escape
def w(path,s):p=R/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s)
def ascii_text(s):
 return s.replace('’',"'").replace('‘',"'").replace('“','"').replace('”','"').replace('—','-').replace('–','-').replace('·','|').replace('•','-').replace('→','to')
resume=R/'web/resume/Mahmoud-Shady-Resume.pdf';resume.parent.mkdir(parents=True,exist_ok=True)
styles={
 'name':ParagraphStyle('name',fontName='ResumeSansBold',fontSize=22,leading=26,spaceAfter=4),
 'role':ParagraphStyle('role',fontName='ResumeSans',fontSize=12,leading=16,spaceAfter=10),
 'section':ParagraphStyle('section',fontName='ResumeSansBold',fontSize=11,leading=15,spaceBefore=12,spaceAfter=7),
 'title':ParagraphStyle('title',fontName='ResumeSansBold',fontSize=10.5,leading=14,spaceBefore=7,spaceAfter=4),
 'body':ParagraphStyle('body',fontName='ResumeSans',fontSize=10,leading=14,spaceAfter=4),
 'meta':ParagraphStyle('meta',fontName='ResumeSans',fontSize=9,leading=13,spaceAfter=4),
 'bullet':ParagraphStyle('bullet',fontName='ResumeSans',fontSize=9.5,leading=13.5,leftIndent=10,firstLineIndent=-10,spaceAfter=4),
}
story=[];plain=[]
def p(s,style='body'):
 t=ascii_text(s);plain.append(t);story.append(Paragraph(esc(t),styles[style]))
p(data['name'],'name');p('Software Engineer | Mobile Application Engineering | Flutter & Dart','role')
p('Cairo, Egypt | '+data['email'],'meta');p(data['linkedin'],'meta');p(data['github'],'meta')
p('PROFESSIONAL SUMMARY','section');p('Software Engineer specializing in complete mobile applications for iOS and Android. Substantial ownership across architecture, implementation, API and platform integration, testing, debugging, delivery, and maintenance. Flutter and Dart are my primary technologies. Personally handled the vast majority of mobile development across my projects.')
p('TECHNICAL SKILLS','section');p('Flutter, Dart, BLoC/Cubit, Provider; Clean Architecture, SOLID, modular architecture, dependency injection; REST APIs, Dio/Retrofit, Firebase Authentication, Cloud Messaging, RevenueCat; Hive, secure storage, local caching; deep links, push/local notifications, responsive UI, Arabic/RTL, animations; unit/widget testing, Git/GitHub, Android/iOS release preparation.')
p('PROFESSIONAL EXPERIENCE','section')
for e in data['experience']:
 p(e['role']+' | '+e['company'],'title');p(e['period'],'meta')
 for bullet in e['description'].splitlines()[:2]:p(bullet,'bullet')
story.append(PageBreak());p(data['name']+' | Selected engineering work','role');p('SELECTED PROJECTS','section')
for proj in data['projects'][:4]:
 p(proj['title']+' | '+proj['category'],'title');p(proj['status'],'meta');p(proj['description']+' '+proj['outcome']);
 if proj['slug']=='hayah':p('Designed modular architecture and authentication foundations; engineered feed/search behavior, responsive Arabic/RTL UI, and focused tests. Under active development; not released.')
 elif proj['slug']=='rejeemat':p('Engineered account, recipe, sharing/deep-link, and persisted reminder workflows. Mobile responsibility excludes backend authorship.')
 else:p('Technologies: '+', '.join(proj['techStack']),'meta')
p('ADDITIONAL MOBILE APPLICATIONS','section');p('HUB Spare Parts: marketplace shopping, orders, and refund workflows using Flutter, Provider, and REST APIs. Doa2k: medication records and timezone-aware reminders using Flutter, Provider, Hive, and local notifications.')
p('EDUCATION','section')
for e in data['education']:p(e['school']+' | '+e['degree'],'title');p(e['period'],'meta')
def footer(canvas,doc):
 canvas.setFont('ResumeSans',8);canvas.setFillColor(colors.HexColor('#555555'));canvas.drawString(42,27,'Mahmoud Shady | Software & Mobile Application Engineering');canvas.drawRightString(553,27,str(doc.page))
SimpleDocTemplate(str(resume),pagesize=(595.28,841.89),rightMargin=42,leftMargin=42,topMargin=36,bottomMargin=46,title='Mahmoud Shady - Software Engineer Resume',author='Mahmoud Shady').build(story,onFirstPage=footer,onLaterPages=footer)
w('web/resume/Mahmoud-Shady-Resume.txt','\n\n'.join(plain)+'\n')

css='''*{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;background:#f6f4ef;color:#222322;font:17px/1.7 system-ui,sans-serif}a{color:#694d91;text-underline-offset:4px}a:focus-visible,button:focus-visible{outline:3px solid #694d91;outline-offset:5px}header,main,footer{max-width:1100px;margin:auto;padding:28px 24px}header{display:flex;flex-wrap:wrap;justify-content:space-between;gap:20px;border-bottom:1px solid #d9dad3}nav{display:flex;flex-wrap:wrap;gap:24px}h1{font-size:clamp(38px,7vw,74px);letter-spacing:-2px;line-height:1.08;font-weight:650;margin:30px 0}h2{font-size:32px;line-height:1.2;letter-spacing:-1px}h3{font-size:23px;line-height:1.3}section{padding:40px 0;border-bottom:1px solid #d9dad3}p{max-width:780px}.eyebrow{font:12px/1.6 monospace;letter-spacing:2px;text-transform:uppercase;color:#694d91}.button{display:inline-block;padding:13px 20px;border:1px solid #222322;border-radius:5px;color:#222322;margin:8px 10px 8px 0}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,300px),1fr));gap:24px}.project{border:1px solid #d9dad3;border-radius:10px;padding:28px;background:#fff}.project p{font-size:15px}.status{font-size:13px;color:#62645f}.progress{height:3px;background:linear-gradient(90deg,#694d91,#ddd0eb);animation:pulse 1.4s ease-in-out infinite;transform-origin:left}@keyframes pulse{50%{opacity:.35}}@media(prefers-reduced-motion:reduce){html{scroll-behavior:auto}*{animation:none!important}}'''
w('web/public.css',css)
def head(title,description,url):
 structured={'@context':'https://schema.org','@type':'Person','name':data['name'],'jobTitle':'Software Engineer','description':'Software Engineer specializing in Mobile Application Engineering with Flutter and Dart.','url':base,'sameAs':[data['linkedin'],data['github']],'email':'mailto:'+data['email'],'alumniOf':{'@type':'CollegeOrUniversity','name':'Minufiya University'},'knowsAbout':['Software Engineering','Mobile Application Development','Flutter','Dart','Software Architecture']}
 return f'''<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>{esc(title)}</title><meta name="description" content="{esc(description)}"><meta name="author" content="Mahmoud Shady"><meta name="theme-color" content="#f6f4ef"><link rel="canonical" href="{url}"><meta property="og:type" content="website"><meta property="og:title" content="{esc(title)}"><meta property="og:description" content="{esc(description)}"><meta property="og:url" content="{url}"><meta property="og:image" content="{base}social-preview.png"><meta property="og:image:width" content="1200"><meta property="og:image:height" content="630"><meta name="twitter:card" content="summary_large_image"><meta name="twitter:title" content="{esc(title)}"><meta name="twitter:description" content="{esc(description)}"><meta name="twitter:image" content="{base}social-preview.png"><script type="application/ld+json">{json.dumps(structured,ensure_ascii=False)}</script>'''
nav=f'''<header><a href="/mahmoud-portfolio/"><strong>Mahmoud Shady</strong></a><nav aria-label="Main navigation"><a href="/mahmoud-portfolio/#work">Work</a><a href="{data['linkedin']}" target="_blank" rel="noopener noreferrer">LinkedIn</a><a href="/mahmoud-portfolio/resume/Mahmoud-Shady-Resume.pdf" download>Resume</a></nav></header>'''
foot=f'''<footer><p>Mahmoud Shady · Software Engineer · Cairo, Egypt</p><a href="mailto:{data['email']}">{data['email']}</a> · <a href="{data['github']}" target="_blank" rel="noopener noreferrer">GitHub</a> · <a href="{data['linkedin']}" target="_blank" rel="noopener noreferrer">LinkedIn</a></footer>'''
cards=''.join(f'''<article class="project"><p class="eyebrow">{esc(x['category'])}</p><h3><a href="case-studies/{x['slug']}/">{esc(x['title'])}</a></h3><p class="status">{esc(x['status'])}</p><p>{esc(x['description'])}</p><p>{esc(x['outcome'])}</p></article>''' for x in data['projects'])
exp=''.join(f'''<article><h3>{esc(x['role'])}</h3><p>{esc(x['company'])} · {esc(x['period'])}</p><ul>{''.join('<li>'+esc(b.removeprefix('• '))+'</li>' for b in x['description'].splitlines()[:3])}</ul></article>''' for x in data['experience'])
education=''.join(f'<h3>{esc(x["school"])}</h3><p>{esc(x["degree"])} · {esc(x["period"])}</p>' for x in data['education'])
expertise=''.join(f'<article><h3>{esc(x["name"])}</h3><p>{esc(x["description"])}</p><p>{esc(" · ".join(x["technologies"]))}</p></article>' for x in data['expertise'])
content=f'''<a class="button" href="#work">Skip to selected work</a><p class="eyebrow">Software Engineer · Mobile Application Engineering</p><h1>Complete apps.<br>Considered engineering.</h1><p>I’m Mahmoud Shady. I turn business requirements into complete mobile applications — from architecture and implementation to integration, delivery, and maintenance. Flutter and Dart are my primary technologies for iOS and Android.</p><a class="button" href="resume/Mahmoud-Shady-Resume.pdf" download>Download resume</a><a class="button" href="{data['linkedin']}" target="_blank" rel="noopener noreferrer">Connect on LinkedIn</a><section id="work"><h2>Selected mobile engineering work</h2><div class="grid">{cards}</div></section><section id="about"><h2>Software engineering with substantial mobile ownership</h2><p>{esc(data['about'].split(chr(10)+chr(10))[1])}</p></section><section id="experience"><h2>Professional experience</h2>{exp}</section><section id="expertise"><h2>Technical expertise</h2><div class="grid">{expertise}</div></section><section id="education"><h2>Education</h2>{education}</section>'''
w('web/index.html',f'''<!doctype html><html lang="en"><head><base href="$FLUTTER_BASE_HREF">{head('Mahmoud Shady | Software & Mobile Application Engineer','Software Engineer building complete iOS and Android applications. Explore mobile architecture, end-to-end engineering, production projects, and Flutter expertise.',base)}<link rel="stylesheet" href="public.css"><link rel="icon" type="image/png" href="favicon.png"><link rel="apple-touch-icon" href="icons/Icon-192.png"><link rel="manifest" href="manifest.json"></head><body><div id="public-content"><div class="progress" role="status" aria-label="Loading interactive portfolio"></div>{nav}<main>{content}</main>{foot}</div><script>window.addEventListener('flutter-first-frame',function(){{document.getElementById('public-content')?.remove();document.body.style.overflow='hidden';}});</script><script src="flutter_bootstrap.js" async></script></body></html>''')
for x in data['projects']:
 path='case-studies/'+x['slug']+'/'
 links=''.join(f'<a class="button" href="{x[k]}" target="_blank" rel="noopener noreferrer">{label}</a>' for k,label in [('playStoreUrl','View on Google Play'),('appStoreUrl','View on the App Store')] if k in x)
 body=f'''<p class="eyebrow">{esc(x['category'])} · {esc(x['status'])}</p><h1>{esc(x['title'])}</h1><h2>{esc(x['heading'])}</h2><p>{esc(x['description'])}</p><section><h2>Mobile engineering ownership</h2><p>{esc(x['ownership'])}</p></section><section><h2>The engineering challenge</h2><p>{esc(x['challenge'])}</p><h2>My responsibilities</h2><ul>{''.join('<li>'+esc(b)+'</li>' for b in x['features'])}</ul></section><section><h2>Delivery and current status</h2><p>{esc(x['outcome'])}</p><p>{esc(' · '.join(x['techStack']))}</p>{links}<a class="button" href="/mahmoud-portfolio/#/projects/{x['slug']}">Open interactive case study</a></section>'''
 w('web/'+path+'index.html',f'<!doctype html><html lang="en"><head>{head(x["title"]+" | Mahmoud Shady — Mobile Engineering",x["description"],base+path)}<link rel="stylesheet" href="../../public.css"><link rel="icon" href="../../favicon.png"></head><body>{nav}<main>{body}</main>{foot}</body></html>')
w('web/robots.txt',f'User-agent: *\nAllow: /\nSitemap: {base}sitemap.xml\n')
w('web/sitemap.xml','<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'+''.join('<url><loc>'+base+path+'</loc></url>' for path in ['']+['case-studies/'+x['slug']+'/' for x in data['projects']])+'</urlset>')
w('web/flutter_bootstrap.js','{{flutter_js}}\n{{flutter_build_config}}\n_flutter.loader.load({config:{canvasKitBaseUrl:"canvaskit/"}});\n')
manifest=json.loads((R/'web/manifest.json').read_text());manifest.update(name='Mahmoud Shady | Software Engineer',short_name='Mahmoud Shady',background_color='#f6f4ef',theme_color='#694d91',description='Software and Mobile Application Engineering portfolio',orientation='any');w('web/manifest.json',json.dumps(manifest,indent=2))
# Original typographic brand assets; no confidential imagery or remote asset dependency.
F=font_pair[0].parent
regular_font=font_pair[0]
bold_font=font_pair[1]
for size,path in [(192,'icons/Icon-192.png'),(512,'icons/Icon-512.png'),(192,'icons/Icon-maskable-192.png'),(512,'icons/Icon-maskable-512.png'),(64,'favicon.png')]:
 image=Image.new('RGB',(size,size),'#222322');draw=ImageDraw.Draw(image);font=ImageFont.truetype(str(bold_font),int(size*.35));draw.text((size*.5,size*.5),'MS',font=font,fill='#f6f4ef',anchor='mm');image.save(R/'web'/path)
im=Image.new('RGB',(1200,630),'#f6f4ef');dr=ImageDraw.Draw(im)
for pos,text,size,color in [((74,66),'MAHMOUD SHADY',24,'#694d91'),((68,168),'Complete apps.',78,'#222322'),((68,258),'Considered engineering.',70,'#222322'),((74,401),'Software Engineer · Mobile Application Engineering',26,'#62645f'),((74,495),'Flutter & Dart / iOS + Android / Architecture → Delivery',23,'#694d91')]:dr.text(pos,text,font=ImageFont.truetype(str(bold_font if size>60 else regular_font),size),fill=color)
dr.line((74,456,1110,456),fill='#d9dad3',width=2);im.save(R/'web/social-preview.png')
print('ATS resume, semantic fallback, seven static case studies, metadata and brand assets generated.')
