class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    #forces all emails to be stores in lowercase to avoid multiples and/or case-sensitive errors
    @user.email.downcase!
    @user.email.strip!

    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authenticate_with_credentials(email, password)
    user = User.where("LOWER(email) = LOWER(?)", email.strip.downcase).first
    if user && user.authenticate(password)
      user
    else
      false
    end
  end
end


