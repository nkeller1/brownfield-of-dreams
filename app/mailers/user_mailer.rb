class UserMailer < ApplicationMailer
  default :from => 'no_reply@admin.com'

  def registration_confirmation(user)
    @user = user
    require 'pry'; binding.pry
    mail(:to => "#{@user.first_name} <#{@user.email}, :subject => 'Registration Confirmation for Dirtfield of Dreams'")
  end
end
