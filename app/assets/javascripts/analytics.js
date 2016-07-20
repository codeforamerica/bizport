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

var trackGlossaryClick = function (term) {

  // GA
  ga('send', 'event', 'glossary', 'click', term, {
    'transport': 'beacon',
  });

  // Keen.io
  window.keen.addEvent('glossary', {
    term: term,
    page: window.location.pathname,
    host: window.location.hostname,
    keen: {
      timestamp: new Date().toISOString()
    }
  }, function(err, res){});

}
