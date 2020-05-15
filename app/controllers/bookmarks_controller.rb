class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_applicant

  def index
    @posts = current_user.bookmark_posts
  end

  def create
    current_user.bookmarks.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path, notice: 'Add to Bookmarks!')
  end

  def destroy
    current_user.bookmarks.find_by(id: params[:id]).destroy
    redirect_back(fallback_location: root_path, notice: 'Un-Bookmarks!')
  end
end
