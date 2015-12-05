// Accordion slider for content

app.modules.eighteenPopup = (function(self) {
  var
    _listener = function() {
      $doc.on('click', '.js-eighteen-yes', function(e) {
        $('.js-eighteen-popup').css({top: -600});
        $('.js-page-cover').css({opacity: 0});

        setTimeout(function() {
          $('.js-eighteen-popup, .js-page-cover').removeClass('active');
        }, 300);

        $.cookie('has_eighteen', 1);
        e.preventDefault();
      });
    };

  self.load = function() {
    _listener();
    $("a.fancybox").fancybox();
  };

  return self;
}(app.modules.eighteenPopup || {}));



