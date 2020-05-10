class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to post_path(@comment.post), notice: '投稿できませんでした...' }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      redirect_to post_path(@post)
    else
      format.html { redirect_to post_path(@comment.post), notice: '投稿できませんでした...' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_id)
  end
end
