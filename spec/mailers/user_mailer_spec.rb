require 'rails_helper'


RSpec.describe UserMailer, type: :mailer do
  before :each do
    @user = create(:user, email: 'example@example.com', confirm_token: 'hi')

    @mail = UserMailer.registration_confirmation(@user).deliver_now
  end

  it 'renders the subject' do
    expect(@mail.subject).to eq('Registration Confirmation for Dirtfield of Dreams')
  end

  it 'renders the receiver email' do
    expect(@mail.to).to eq([@user.email])
  end

  it 'renders the sender email' do
    expect(@mail.from).to eq(['no_reply@email.com'])
  end

  it 'assigns @name' do
    expect(@mail.body.encoded).to match(@user.first_name)
  end
end
