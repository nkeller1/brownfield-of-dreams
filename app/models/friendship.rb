class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"


  # def self.destroy_friendship(user_id, friend_id)
  #   friendship1 = Friendship.find_by(user_id: user_id, friend_id: friend_id)
  #   friendship2 = Friendship.find_by(user_id: friend_id, friend_id: user_id)
  #   friendship1.destroy
  #   friendship2.destroy
  # end
end
