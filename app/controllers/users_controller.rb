class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_user, except: [:create]

  def index
    @users = User.all

    render json: @users
  end


  def create
    @user = User.new(user_params)
    if @user.save
      render json: { messages: "Wait for Admin Approve Request", username: @user.name, email: @user.email }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end




  private

  def user_params
    params.require(:user).permit(:name, :email, :role_id, :password, :status)
  end

end
