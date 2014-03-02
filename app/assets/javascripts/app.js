var app = {
  init: function () {
    this.initMarkdownConverter();
    this.initFormSubmitSpinner();
    this.initWmd();
  },

  flash: function (type, message, prependTo) {
    $('.alert').remove();
    //$("html, body").animate({ scrollTop: 0 }, 'fast');
    if (type == 'notice') {
      type = 'success';
    }
    var flashContent = '<div class="alert alert-' + type + '">' + message + '</div>';
    if (prependTo) {
      prependTo.prepend(flashContent);
      prependTo.find('.alert').hide().fadeIn(500);
    } else {
      $('#flash').html(flashContent).hide().fadeIn(500);
    }
  },

  user_signed_in: function () {
    return $('body').data('signed-in');
  },

  markdown: function (selector) {
    var converter = new Attacklab.showdown.converter();
    $(selector).each(function () {
      var html = converter.makeHtml($(this).text());
      $(this).html(html)
    });
  },

  initMarkdownConverter: function () {
    this.markdown('.markdown');
  },

  initFormSubmitSpinner: function () {
    $('.spin-on-submit').live('submit', function () {
      $(this).find('button[type=submit]').addClass('disabled');
      $(this).find('button[type=submit] i').removeClass().addClass('icon-refresh icon-spin');
    });
  },

  initWmd: function () {
    $(".my_wmd").wmd();
  }
};
