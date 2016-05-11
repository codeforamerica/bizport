(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-74906812-2', 'auto');
ga('require', 'linkid');
ga('send', 'pageview');

/**
* From https://support.google.com/analytics/answer/1136920?hl=en
* Function that tracks a click on an outbound link in Analytics.
* This function takes a valid URL string as an argument, and uses that URL string
* as the event label. Setting the transport method to 'beacon' lets the hit be sent
* using 'navigator.sendBeacon' in browsers that support it.
*/
var trackOutboundLink = function(url) {

  // GA
  ga('send', 'event', 'outbound', 'click', url, {
    'transport': 'beacon',
    'hitCallback': function(){ document.location = url; }
  });

  // Keen.io
  window.keen.addEvent('outbound', {
    item: url,
    page: window.location.pathname,
    host: window.location.hostname,
    keen: {
      timestamp: new Date().toISOString()
    }
  }, function(err, res){});

}
