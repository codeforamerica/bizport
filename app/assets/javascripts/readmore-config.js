$(function(){
  $('.step-section').readmore({
    collapsedHeight: 300,
    heightMargin: 300,
    speed: 250,
    moreLink: '<a href="#" class="readmore text-center"><span class="arrow arrow-more"></span></a>',
    lessLink: '<a href="#" class="readmore text-center"><span class="arrow arrow-less"></span></a>',

    blockCSS: 'display: block;', // override default CSS, which has width settings that conflict with Foundation
    
    // seems like these classes should be added by the library, but they're not...
    beforeToggle: function(trigger, element, expanded) { 
      if (!expanded) { // The "open" link was clicked
        $(element).addClass('readmore-expanded');
        $(element).removeClass('readmore-collapsed');
      } else if (expanded) { // The "close" link was clicked
        $(element).addClass('readmore-collapsed');
        $(element).removeClass('readmore-expanded');
      }
    },

    afterToggle: function(trigger, element, expanded) {
      if(! expanded) { // The "Close" link was clicked
        $('html, body').animate( { scrollTop: element.offset().top }, {duration: 250 } );
      }
    },
  });
});
