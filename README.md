# Mahmoud Shady — Software & Mobile Application Engineering

A Flutter Web portfolio focused on complete mobile products, architecture, technical ownership, and delivery. It retains the feature-based presentation, Cubit navigation, repository, local data source, and GetIt dependency setup.

## Content

`assets/data/profile.json` is the public source of truth for employment, projects, expertise, and education, reconciled with the verified LinkedIn profile on 11 October 2026. Employment dates overlap; do not sum them into a total experience figure. Hayah is active development and unreleased. Rejeemat's approximate three-month timeline refers to initial application completion.

Seven interactive case studies have seven crawlable HTML counterparts. Original engineering illustrations describe capabilities; they are not screenshots of private applications. Private repositories, internal endpoints, unsupported metrics, and unverified certificates are excluded.

## Develop and validate

Use Flutter **3.47.2** / Dart **3.13.2**, matching the pinned deployment workflow.

```sh
flutter pub get
flutter analyze --no-pub
flutter test --no-pub
flutter build web --release --base-href /mahmoud-portfolio/ --no-pub
python3 tool/validate_release.py
git diff --check
```

Tests cover content boundaries, case-study navigation and direct URLs, mobile navigation, keyboard activation, rapid section changes, common viewports, large text, and reduced motion. The release validator checks static pages, local links, sitemap, metadata, resume consistency, basic text contrast, and JavaScript size.

For a local release preview, serve a directory containing `mahmoud-portfolio/` mapped to `build/web`, then visit that path. This matches the GitHub Pages base path. Serving the build at an unrelated root without changing the base path breaks asset resolution.

## Public assets and resume

The two-page resume is at `web/resume/Mahmoud-Shady-Resume.pdf`, with a plain-text companion. It uses selectable text, embedded fonts, standard sections, and accurate experience without skill scores or fabricated metrics.

After changing public data, regenerate HTML, metadata, brand images, and resume:

```sh
python3 -m pip install reportlab pillow
python3 tool/prepare_public_assets.py
```

The generator requires Arial on macOS or DejaVu Sans on Linux and embeds the document fonts. Review the generated PDF after content changes, then rebuild and validate. The Flutter app has no new runtime dependencies.

## Design and accessibility

Warm ivory, ink typography, restrained violet accents, original project artwork, and contrasting contact content form the visual system. Typography extends the existing `AppTypography` system. Navigation, buttons, case studies, and diagrams expose semantics. External links use the existing URL launcher, which supplies `noopener,noreferrer` on web.

Shared motion uses finite opacity/transform reveals, staggered cards, hover movement, section scrolling, and page transitions. Flutter Web maps browser `prefers-reduced-motion` to accessibility features; custom animations and animated section scrolling are disabled accordingly. The HTML fallback also respects reduced motion.

The HTML entry contains useful semantic content until Flutter's first frame. Static case studies remain readable without JavaScript. Titles, descriptions, canonical URLs, Person structured data, Open Graph images, manifest, favicon, sitemap, and robots configuration are included.

## Deployment

Verified existing hosting: **https://mahmoudshady20.github.io/mahmoud-portfolio/**.

The GitHub Pages workflow pins the validated Flutter SDK and runs analysis, tests, build, and release validation. A push to `main` or workflow dispatch publishes the site. **Do not push to `main` or dispatch deployment until the owner approves publishing.** No hosting-provider change is required.

After approved deployment, verify the live page, case studies, resume, sharing image, and product destinations. Only then synchronize the verified URL to LinkedIn Contact Info and Featured with owner approval. LinkedIn settings, personal screening answers, and authentication data are not stored in this public repository.
