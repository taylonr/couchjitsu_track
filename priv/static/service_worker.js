self.addEventListener('install', function(e) {
  e.waitUntil(
    caches.open('trackjitsu').then(function(cache) {
      return cache.addAll([
        '/',
        '/statistics',
        '/assets/couchjitsu_large_logo.png',
        '/assets/couchjitsu_logo.eps',
        '/css/app.css',
        '/js/app.js',
        '/js/semantic.js'
      ]);
    })
  );
});

self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request).then(function(response) {
      if(response) {
        return response;
      }

      caches.open('trackjitsu').then(function(cache){
        return cache.add(event.request.url);
      });
    })
  );
});