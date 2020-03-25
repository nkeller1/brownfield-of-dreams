require 'rails_helper'

describe Video, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :description}
    it {should validate_presence_of :thumbnail}
  end

  describe 'relationships' do
    it {should belong_to :tutorial}
    it {should have_many :user_videos}
    it {should have_many(:users).through(:user_videos)}
  end
end
