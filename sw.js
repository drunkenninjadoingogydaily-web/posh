var CACHE = "posh-v3";
var ASSETS = ["/", "/index.html", "/manifest.json"];

self.addEventListener("install", function(e) {
  e.waitUntil(
    caches.open(CACHE).then(function(cache) {
      return cache.addAll(ASSETS).catch(function() { return; });
    })
  );
  self.skipWaiting();
});

self.addEventListener("activate", function(e) {
  e.waitUntil(
    caches.keys().then(function(keys) {
      return Promise.all(
        keys.filter(function(k) { return k !== CACHE; })
            .map(function(k) { return caches.delete(k); })
      );
    })
  );
  self.clients.claim();
});

self.addEventListener("fetch", function(e) {
  // Skip non-GET requests (Firebase uses POST)
  if (e.request.method !== "GET") return;
  // Skip Firebase and external requests
  if (e.request.url.includes("firestore") ||
      e.request.url.includes("firebase") ||
      e.request.url.includes("googleapis") ||
      e.request.url.includes("gstatic")) return;

  e.respondWith(
    caches.match(e.request).then(function(r) {
      return r || fetch(e.request).then(function(response) {
        // Only cache valid GET responses
        if (!response || response.status !== 200 || response.type === "opaque") {
          return response;
        }
        var clone = response.clone();
        caches.open(CACHE).then(function(cache) {
          cache.put(e.request, clone);
        });
        return response;
      }).catch(function() {
        return caches.match("/index.html");
      });
    })
  );
});
