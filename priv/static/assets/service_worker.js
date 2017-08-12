self.addEventListener('install', function(e) {
  e.waitUntil(
    caches.open('airhorner').then(function(cache) {
      return cache.addAll([
        '/',
        '/assets/couchjitsu_large_logo.png',
        '/assets/couchjitsu_logo.eps',
        '/assets/themes',
        '/css/app.css',
        '/js/app.js',
        '/js/semantic.js'
      ]);
    })
  );
});

self.addEventListener('fetch', function(event) {
  console.log(event.request.url);
});