class Video < ApplicationRecord
  validates_presence_of :title, :description, :thumbnail
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
