/**
 * Инициализация приложения
 *
 **/

$doc.ready(function() {
  var item;

  if (!app.modules) {
    return false;
  }

  for (item in app.modules) {
    if (app.modules[item].ready) {
      app.modules[item].ready();
    }
  }
});

$win.load(function() {
  if (!app.modules) {
    return false;
  }

  setTimeout(function() {
    var item;
    for (item in app.modules) {
      if (app.modules[item].load) {
        app.modules[item].load();
      }
    }
  }, 10);
});
