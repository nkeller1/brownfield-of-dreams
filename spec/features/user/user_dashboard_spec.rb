require 'rails_helper'

RSpec.describe 'User dashboard' do
  before :each do
    User.destroy_all

    @user_1 = User.create(
      email: 'steven.a.anderson2012@gmail.com',
      first_name: 'Steve',
      last_name: 'Anderson',
      password: 'pass_1',
      token: Figaro.env.gh_steve_token,
      username: 'alerrian',
      role: :default
    )
    @user_2 = User.create(
      email: 'keller.nathan@gmail.com',
      first_name: 'Nathan',
      last_name: 'Keller',
      password: 'pass_1',
      token: Figaro.env.gh_nathan_token,
      username: 'nkeller1',
      role: :default
    )

    @user_3 = create(:user)
  end

  vcr_options = { :record => :new_episodes}
  it 'can see a github section', :js, :vcr => vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_1.email
    fill_in 'session[password]', with: @user_1.password

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

  it 'it sees different repos for different users', :js, :vcr => vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_2.email
    fill_in 'session[password]', with: @user_2.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#github' do
      expect(page).to have_link('monster_shop_1911')
      expect(page).to have_link('paired_pet_shop')
      expect(page).to have_link('futbol')
      expect(page).to have_link('battleship')
      expect(page).to have_link('1911Enigma')
    end
  end

  it 'does not show repos without a token' do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_3.email
    fill_in 'session[password]', with: @user_3.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#github' do
      expect(page).to_not have_content('Github Repositories')
    end
  end
end
