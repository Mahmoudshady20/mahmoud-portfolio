{{flutter_js}}
{{flutter_build_config}}
// Update legacy Flutter workers to the SDK's retiring worker before startup.
_flutter.loader.load({
  serviceWorkerSettings: {serviceWorkerVersion: {{flutter_service_worker_version}}},
  config: {canvasKitBaseUrl: "canvaskit/"}
});
