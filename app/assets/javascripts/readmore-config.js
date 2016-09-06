$(function(){
  $('.readmore-section').readmore({
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
        window.keen.addEvent("readmore", {
          item: $(element).children().first().text().toLowerCase().replace(/[^\w ]+/g,'').replace(/ +/g,'-'),
          page: window.location.pathname,
          host: window.location.hostname,
          keen: {
            timestamp: new Date().toISOString()
          }
        }, function(err, res){});
      } else if (expanded) { // The "close" link was clicked
        $(element).addClass('readmore-collapsed');
        $(element).removeClass('readmore-expanded');
      }
    },
  });
});
