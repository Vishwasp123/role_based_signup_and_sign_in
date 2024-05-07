class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      if @user.status == "approve"
        token = JWT.encode({ user_id: @user.id }, Rails.application.secrets.secret_key_base, 'HS256')

        render json: { token: token, user_email: @user.email }
      else
        render json: { messages: "Your request has not been approved yet" }
      end
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
