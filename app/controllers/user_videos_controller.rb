class UserVideosController < ApplicationController
  before_action :verify_user

  def new
  end

  def create
    user_video = UserVideo.new(user_video_params)
    user_video.user_id = current_user.id

    if current_user.user_videos.find_by(video_id: user_video.video_id)
      flash[:error] = "Already in your bookmarks"
    elsif user_video.save
      flash[:success] = "Bookmark added to your dashboard!"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end

  def verify_user
    if current_user.nil?
      flash[:notice] = 'User must login to bookmark videos.'
      redirect_back(fallback_location: root_path)
    end
  end
end
