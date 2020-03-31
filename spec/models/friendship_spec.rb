require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should belong_to :friend}
  end

  describe 'class methods' do
    it '#create_friendship' do
      user = User.create(
        email: 'steven.a.anderson2012@gmail.com',
        first_name: 'Steve',
        last_name: 'Anderson',
        password: 'pass_1',
        token: Figaro.env.gh_steve_token,
        username: 'alerrian',
        role: :default,
        email_confirmed: true
      )
      friend = User.create(
        email: 'keller.nathan@gmail.com',
        first_name: 'Nathan',
        last_name: 'Keller',
        password: 'pass_1',
        token: Figaro.env.gh_nathan_token,
        username: 'nkeller1',
        role: :default,
        email_confirmed: true
      )

      friendship = Friendship.create_friendship(user.id, friend.id)

      expect(friendship.length).to eq(2)
      expect { Friendship.create_friendship(user.id, friend.id) }.to change { Friendship.all.length }.by(2)
    end

    it '#destroy_friendship' do
      Friendship.destroy_all

      user = User.create(
        email: 'steven.a.anderson2012@gmail.com',
        first_name: 'Steve',
        last_name: 'Anderson',
        password: 'pass_1',
        token: Figaro.env.gh_steve_token,
        username: 'alerrian',
        role: :default,
        email_confirmed: true
      )
      friend = User.create(
        email: 'keller.nathan@gmail.com',
        first_name: 'Nathan',
        last_name: 'Keller',
        password: 'pass_1',
        token: Figaro.env.gh_nathan_token,
        username: 'nkeller1',
        role: :default,
        email_confirmed: true
      )

      friendship = Friendship.create_friendship(user.id, friend.id)

      expect(friendship.length).to eq(2)
      expect { Friendship.create_friendship(user.id, friend.id) }.to change { Friendship.all.length }.by(2)

      friendship = Friendship.destroy_friendship(user.id, friend.id)

      expect { Friendship.find(friendship.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
