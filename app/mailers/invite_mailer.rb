class InviteMailer < ApplicationMailer
  default from: 'no_reply@email.com'

  def invite(name, email, inviter)
    @email = email
    @name = name
    @inviter = inviter

    mail(to: "#{@name} <#{@email}>", subject: "You've been invited!")
  end
end
