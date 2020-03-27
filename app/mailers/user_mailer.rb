class UserMailer < ApplicationMailer
  default :from => 'no_reply@admin.com'

  def registration_confirmation(user)
    @user = current_user
    mail(:to => "#{user.name} <#{user.email}, :subject => 'Registration Confirmation for Dirtfield of Dreams'")
  end
end
