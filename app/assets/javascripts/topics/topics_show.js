app.topics.show = {
  init: function () {
    that = this;
    this.initEdit();
    this.initCancelEdit();
  },

  initEdit: function () {
    $('.link .edit').live('click', function () {
      var $link = $(this).closest('.link');
      var $linkContent = $link.find('.link-content');
      var $linkForm = $link.find('.link-form-container');
      var $spinner = $(this).find('.icon-spin');

      $spinner.show();
      $.ajax({
        url: $linkForm.data('url'),
        success: function (result) {
          $link.removeClass('selected');

          $linkContent.hide();
          $linkForm.html(result).show();
          $spinner.hide();
          $linkForm.find(".my_wmd").wmd();
        }
      });
    });
  },

  initCancelEdit: function () {
    $('.link .cancel').live('click', function (e) {
      var $link = $(this).closest('.link');
      var $linkContent = $link.find('.link-content');
      var $linkForm = $link.find('.link-form-container');

      $linkContent.show();
      $linkForm.hide();
      e.preventDefault();
      return false;
    });
  }
};