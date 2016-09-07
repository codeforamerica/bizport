// jQuery extension to find containing text without case sensitivity
jQuery.expr[':'].icontains = function(a, i, m) {
  return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};
