require 'rails_helper'


describe 'A new user can be created' do
  it 'can navigate to the register page' do

  visit '/'

  click_on "Register"

  expect(current_path).to eq('/register')
  end

  it "can create a new user" do

    visit '/register'

    fill_in 'user_email', with: "example@example.com"
    fill_in 'user_first_name', with: "Joe"
    fill_in 'user_last_name', with: "Schmo"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"

    click_on "Create Account"

    expect(current_path).to eq('/dashboard')
  end
end
