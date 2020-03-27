class UserMailer < ApplicationMailer
  default from: 'no_reply@email.com'

  def registration_confirmation(user)
    @user = user
    mail(to: "#{@user.first_name} <#{@user.email}>", subject: 'Registration Confirmation for Dirtfield of Dreams')
  end
end
