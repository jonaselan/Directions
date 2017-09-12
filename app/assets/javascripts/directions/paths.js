$(document).on('turbolinks:load', function() {
  if (!(page.controller() === 'directions' && page.action() === 'paths')) { return; }
  console.log('sim');
});
