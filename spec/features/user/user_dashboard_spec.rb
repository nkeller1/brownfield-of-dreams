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

  vcr_options = { record: :new_episodes }
  it 'can see a repos section with listed repos', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_1.email
    fill_in 'session[password]', with: @user_1.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#repos' do
      expect(page).to have_link('activerecord-obstacle-course')
      expect(page).to have_link('adopt_dont_shop')
      expect(page).to have_link('adopt_dont_shop_paired')
      expect(page).to have_link('algorithm_sort')
      expect(page).to have_link('b2-mid-mod')
    end
  end

  it 'it sees different repos for different users', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_2.email
    fill_in 'session[password]', with: @user_2.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#repos' do
      expect(page).to have_css('.repo', count: 5)
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

    expect(page).to_not have_content('Github')
    expect(page).to_not have_content('Repositories')
    expect(page).to_not have_content('Followers')
    expect(page).to_not have_content('Following')
  end

  it 'can see a repos section with github followers', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_1.email
    fill_in 'session[password]', with: @user_1.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#followers' do
      expect(page).to have_content('Followers')
      expect(page).to have_link('letrungcu')
      expect(page).to have_link('iEv0lv3')
      expect(page).to have_link('nkeller1')
    end
  end

  it 'can see a followers section with a different user', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_2.email
    fill_in 'session[password]', with: @user_2.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#followers' do
      expect(page).to have_content('Followers')
      expect(page).to have_link('PaulDebevec')
      expect(page).to have_link('alerrian')
    end
  end

  it 'can see a section for github following', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_1.email
    fill_in 'session[password]', with: @user_1.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#following' do
      expect(page).to have_content('Following')
      expect(page).to have_link('rcallen89')
      expect(page).to have_link('dionew1')
      expect(page).to have_link('nkeller1')
      expect(page).to have_link('BrianZanti')
      expect(page).to have_link('iEv0lv3')
    end
  end

  it 'can see a following section with a different user', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_2.email
    fill_in 'session[password]', with: @user_2.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '#following' do
      expect(page).to have_content('Following')
      expect(page).to have_link('PaulDebevec')
      expect(page).to have_link('alerrian')
      expect(page).to have_link('BrianZanti')
    end
  end

  it 'oauth, connecting to github', :js, vcr: vcr_options do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: @user_3.email
    fill_in 'session[password]', with: @user_3.password

    click_on 'Log In'

    expect(page).not_to have_content('Github')

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                  provider: 'github',
                                                                  uid: '123545',
                                                                  credentials: { token: ENV['GH_NATHAN_TOKEN'] }
                                                                })

    click_button 'Connect to Github'

    expect(page).to have_content('Github')
  end

  it 'see that the account is awaiting email confirmation before e mail confirmation', :js, vcr: vcr_options do
    user = create(:user, email_confirmed: false)

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(user.email_confirmed).to eq(false)
    expect(page).to have_content('Status: Awaiting E-mail confirmation')
  end

  it 'see that the account is active after a user has confirmed thier e mail', :js, vcr: vcr_options do
    user = create(:user, email_confirmed: true)

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(user.email_confirmed).to eq(true)
    expect(page).to have_content('Status: Active')
  end
end
