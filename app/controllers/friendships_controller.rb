class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(username: params[:username])
    new_friendship = current_user.create_friendship(friend.id)
    flash[:success] = "Friend added sucessfully!"
    current_user.reload

    redirect_to dashboard_path
  end

end
