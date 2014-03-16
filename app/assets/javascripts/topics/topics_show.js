app.topics.show = {
  init: function () {
    that = this;
    this.initEdit();
    this.initCancelEdit();
  },

  initEdit: function () {
    $('.votable .edit').live('click', function (e) {
      var $votable = $(this).closest('.votable');
      var $votableContent = $votable.find('.votable-content');
      var $votableForm = $votable.find('.votable-form-container');
      var $spinner = $(this).find('.icon-spin');

      $spinner.show();
      $.ajax({
        url: $votableForm.data('url'),
        success: function (result) {
          $votable.removeClass('selected');

          $votableContent.hide();
          $votableForm.html(result).show();
          $spinner.hide();
          $votableForm.find(".my_wmd").wmd();
        }
      });
      e.preventDefault();
      return false;
    });
  },

  initCancelEdit: function () {
    $('.votable .cancel').live('click', function (e) {
      var $votable = $(this).closest('.votable');
      var $votableContent = $votable.find('.votable-content');
      var $votableForm = $votable.find('.votable-form-container');

      $votableContent.show();
      $votableForm.hide();
      e.preventDefault();
      return false;
    });
  }
};