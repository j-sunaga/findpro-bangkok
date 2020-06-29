class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.js { render :index }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'comment deleted'
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_id)
  end
end
