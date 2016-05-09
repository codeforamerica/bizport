$(document).ready(function () {
  instrumentChecklist();
});

function instrumentChecklist() {
  $('.checklist-item label').click(function () {
    sendEvent( $(this).text().toLowerCase().trim().replace(/[^\w ]+/g,'').replace(/ +/g,'-') );
  });
}

function sendEvent(checklistItem) {
  window.keen.addEvent("checklist", {
    item: checklistItem,
    page: window.location.pathname,
    host: window.location.hostname,
    keen: {
      timestamp: new Date().toISOString()
    }
  }, function(err, res){});
}
