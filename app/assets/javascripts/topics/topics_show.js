app.topics.show = {
  init: function () {
    that = this;
    this.initEdit();
    this.initCancelEdit();
    this.initComment();
    this.initSubmitComment();
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
  },

  initComment: function() {
    $('.comment-link').live('click', function() {
      var $votable = $(this).closest('.votable');
      $votable.find('.post-comments-container').show();
      $votable.find('.comment-form-container').show();
      $votable.find('.add-comment-container').hide();
    });

    $('.comment-form .cancel').live('click', function() {
      var $votable = $(this).closest('.votable');
      $votable.find('.comment-form-container').hide();
      $votable.find('.add-comment-container').show();
    });
  },

  initSubmitComment: function() {
    $('.comment-form').live('submit', function(e) {
      var $post = $(this).closest('.votable');
      var $form = $(this);
      var $spinner = $form.find('.submit-comment i');
      var url = $(this).attr('action');
      $spinner.show();
      $.ajax({
        type: 'POST',
        url: url,
        dataType: 'json',
        data: $(this).serialize(),
        success: function (data) {
          $spinner.hide();
          if (data.success) {
            $post.find('.post-comments .add-comment-container').before(data.partial);
            $post.find('.comment-form-container').hide();
            $post.find('.add-comment-container').show();
            $post.find('textarea[name=content]').val('');
            $post.find('.alert').remove();
          } else {
            app.flash('error', data.error, $post.find('.comment-form-container'));
          }
        }
      });
      e.preventDefault();
      return false;
    });
  }
};