{{flutter_js}}
{{flutter_build_config}}
// Content-derived cache keys are injected by tool/finalize_web.py after build.
for (const build of _flutter.buildConfig.builds) {
  if (build.mainJsPath) build.mainJsPath += '?release=__RELEASE__';
}
// No new offline worker: the generated retiring worker cleans up old installs.
// Only unregister this application's worker, never another app on the origin.
async function startPortfolio() {
  if ('serviceWorker' in navigator) {
    try {
      const scope = new URL('./', document.baseURI).href;
      const registrations = await navigator.serviceWorker.getRegistrations();
      await Promise.all(registrations.filter(r => r.scope === scope).map(r => r.unregister()));
    } catch (_) { /* Startup still works if storage access is restricted. */ }
  }
  await _flutter.loader.load({config: {canvasKitBaseUrl: 'canvaskit/'}});
}
startPortfolio().catch(() => window.dispatchEvent(new Event('portfolio-load-error')));
