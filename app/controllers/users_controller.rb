class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id

      # send confirmation email with token to register
      user.set_confirmation_token
      user.save(validate: false)
      UserMailer.registration_confirmation(user).deliver_now

      flash[:notice] = "Logged in as #{user.first_name}"
      flash[:success] = 'This account has not yet been activated. Please check your email.'

      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to "/register"
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])

    if user
      user.validate_email
      user.save(validate: false)
      redirect_to dashboard_path
      flash[:success] = 'Thank you! Your account is now activated.'
    else
      flash[:error] = 'Sorry. User does not exist.'
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
