class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  validates_presence_of :last_name
  enum role: %i[default admin]
  has_secure_password

  validates :password, confirmation: { presence: true, case_sensitive: true }

  def gh_repos
    gh_search = GithubSearch.new(token)
    gh_search.repos[0..4].map do |repo|
      Repo.new(repo)
    end
  end

  def gh_followers
    gh_search = GithubSearch.new(token)
    gh_search.followers.map do |follower|
      Githubmember.new(follower)
    end
  end

  def gh_following
    gh_search = GithubSearch.new(token)
    gh_search.following.map do |member|
      Githubmember.new(member)
    end
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def get_bookmarks
    videos = Video.joins(:user_videos)
                  .where("user_videos.user_id = #{self.id}")
                  .order(:tutorial_id)
                  .order(:position)

    videos.inject(Hash.new([])) do |bookmarks, video|
      (bookmarks[video.tutorial_id] += []).push(video)
      bookmarks
    end
  end
end
