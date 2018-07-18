module V1
 class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def show
      current_user ? head(:ok) : head(:unauthorized)
    end

    def create
      @user = User.find_by(email: params[:email])
      # this syntax 👇 is shortform for => user && user.valid_password
      if @user && @user.valid_password?(params[:password])
        render json: @user.as_json(only: [:id, :email, :authentication_token]), status: :created
      else
        head(:unauthorized)
      end
    end

    def destroy
      current_user&.authentication_token = nil
      if current_user&.save
        head(:ok)
      else
        head(:unauthorized)
      end
    end
  end
end
