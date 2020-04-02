class InvitesController < ApplicationController
  def new; end

  def create
    handle = params[:github_handle]
    token = current_user.token

    new_invite = InviteSearch.new(handle, token)

    email = new_invite.invitee_email
    invitee_name = new_invite.invitee_name
    inviter = current_user.username

    send_invitation(email, invitee_name, inviter)

    redirect_to dashboard_path
  end

  private

    def send_invitation(email, invitee_name, inviter)
      if email.nil?
        flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
      else
        InviteMailer.invite(invitee_name, email, inviter).deliver_now
        flash[:success] = 'Successfully sent invite!'
      end
    end
end
