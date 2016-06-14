$(function(){
  // JS is live!
  $('body').removeClass('no-js');

  // init foundation
  $(document).foundation();
  
  // init custom JS
  setUpAccordions();

  // set global event handlers
  $(window).resize(function () {
    setUpAccordions();
  });

  function setUpAccordions () {
    if ( $(window).width() < 1024 ) {
      $('.accordion').map(function (index, el) {
        var $el = $(el);
        $el.removeClass('desktop');
        new Foundation.Accordion( $el );
      });
    } else {
      $('.accordion').map(function (index, el) {
        var $el = $(el);
        $el.foundation('destroy');
        if ( !$el.hasClass('desktop') ) {
          $el.addClass('desktop');
        }
      });
    }
  }

});
