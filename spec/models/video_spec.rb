require 'rails_helper'

describe Video, type: :model do

  describe 'relationships' do
    it {should belong_to :tutorial}
    it {should have_many :user_videos}
    it {should have_many(:users).through(:user_videos)}
  end
end
