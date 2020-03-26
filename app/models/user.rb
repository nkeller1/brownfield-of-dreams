class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  enum role: [:default, :admin]
  has_secure_password

  validates :password, confirmation: { presence: true, case_sensitive: true }

  def gh_repos
    gh_search = GithubSearch.new(self.token)
    gh_search.repos[0..4].map do |repo|
      Repo.new(repo)
    end
  end

  def gh_followers
    gh_search = GithubSearch.new(self.token)
    gh_search.followers.map do |follower|
      Follower.new(follower)
    end
  end

  def gh_following
    gh_search = GithubSearch.new(self.token)
    gh_search.following.map do |member|
      Following.new(member)
    end
  end
end
