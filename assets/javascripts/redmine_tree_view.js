
var rtv_closed_class = 'rtv_closed';
var rtv_toggle_class = 'rtv_project_toggle';

function rtv_toggle_elem(elem) {
  var current = $(elem);
  var target = $('ul.' + current.data('toggle-target'));
  var current_is_closed = current.hasClass(rtv_closed_class);

  if (current_is_closed) {
    current.removeClass(rtv_closed_class);
    target.show();
  } else {
    current.addClass(rtv_closed_class);
    target.hide();
  }
}

$(function() {
  $('span.rtv_project_toggle').on('click', function() {
    rtv_toggle_elem(this);
  });

  $('#rtv_expand_all').on('click', function() {
    $('.' + rtv_toggle_class + '.' + rtv_closed_class).each(function() {
      rtv_toggle_elem(this);
    });
  });

  $('#rtv_collapse_all').on('click', function() {
    $('.' + rtv_toggle_class + ':not(.' + rtv_closed_class + ')').each(function() {
      rtv_toggle_elem(this);
    });
  });

});

