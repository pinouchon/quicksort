class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    response = {success: false}
    if params[:post_id].to_s.empty? || params[:post_type].to_s.empty?
      response[:error] = 'Can not submit comment. Try refreshing the page.'
    elsif params[:content].to_s.empty? || params[:content].length < 15
      response[:error] = 'Enter at least 15 characters.'
    else
      c = Comment.create({post_id: params[:post_id],
                          post_type: params[:post_type],
                          content: params[:content],
                          user_id: current_user.id})
      if c.valid?
        response[:success] = true
        response[:partial] = render_to_string(partial: 'comments/comment.html.erb', locals: {comment: c})
      end
    end

    respond_to do |format|
      format.html { raise 'html format not supported' }
      format.json do
        render json: response
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_path @comment.post }
      #format.json { head :no_content }
    end
  end
end
