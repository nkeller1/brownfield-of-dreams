require 'rails_helper'

RSpec.describe 'User dashboard' do
  before :each do
    User.destroy_all

    @user = User.create!(
      email: 'steven.a.anderson2012@gmail.com',
      first_name: 'Steve', 
      last_name: 'Anderson', 
      password: 'pass_1', 
      token: '14183b448e4cf1d63db9f6917313c9f4f9e371b7', 
      username: 'alerrian',
      role: :default)
  end

  vcr_options = {:record => :new_episodes}
  it 'can see a github section', :js, :vcr => vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#github' do
      expect(page).to have_link('activerecord-obstacle-course')
      expect(page).to have_link('adopt_dont_shop')
      expect(page).to have_link('adopt_dont_shop_paired')
      expect(page).to have_link('algorithm_sort')
      expect(page).to have_link('b2-mid-mod')
    end
  end
end
