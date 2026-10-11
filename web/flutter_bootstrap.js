{{flutter_js}}
{{flutter_build_config}}
// Version the entry point so browser caches cannot retain the previous application.
for (const build of _flutter.buildConfig.builds) {
  if (build.mainJsPath) build.mainJsPath += '?release=20261011';
}
// Update legacy Flutter workers to the SDK's retiring worker before startup.
_flutter.loader.load({
  serviceWorkerSettings: {serviceWorkerVersion: {{flutter_service_worker_version}}},
  config: {canvasKitBaseUrl: "canvaskit/"}
});
