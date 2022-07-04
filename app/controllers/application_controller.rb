class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate
  include ActionController::Cookies

  private

  def authenticate
    jwt = cookies[:jwt]
    # return head :unauthorized unless jwt

    begin
      @decoded = jwt_decode(jwt)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
