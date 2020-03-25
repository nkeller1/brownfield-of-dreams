class UsersController < ApplicationController
  def show
    user = User.find(session[:user_id])
    token = user.token
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{token}")
    @repos = JSON.parse(response.body, symbolize_names: true)

    
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to "/register"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
