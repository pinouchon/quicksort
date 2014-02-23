// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery-1.8.3.min.js
//= require jquery_ujs
//= require_tree .

$('.ajaxForm').live('submit', function() {

    $(this).find('button[type=submit]').addClass('disabled');
    $(this).find('button[type=submit] i').removeClass().addClass('icon-refresh icon-spin');
});
$(function () {
    var converter = new Attacklab.showdown.converter();
    $('.markdown').each(function () {
        var html = converter.makeHtml($(this).text());
        $(this).html(html)
    })
});

var app = {
  init: function() {
  },

  flash: function(type, message) {
    $('.alert').remove();
    //$("html, body").animate({ scrollTop: 0 }, 'fast');
    if (type == 'notice') {
      type = 'success';
    }
    $('#flash').html('<div class="alert alert-'+type+'">'+message+'</div>').hide().fadeIn('slow');
  },

  user_signed_in: function () {
    return $('body').data('signed-in');
  }
};
