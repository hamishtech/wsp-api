class Api::V1::AuthenticationController < ApplicationController
  require 'net/http'
  require 'uri'
  skip_before_action :authenticate, only: :login_google
  def login_google
    uri = URI('https://www.googleapis.com/oauth2/v3/userinfo')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  { 'Content-Type' => 'application/json',
                                    'Authorization' => "Bearer #{google_login_params[:access_token]}" })

    response = http.request(request)
    return head :unauthorized if response.code != '200'

    body = HashWithIndifferentAccess.new JSON.parse(response.body)

    body.keep_if { |k, _v| User.attribute_names.include?(k.to_s) }

    render json: sign_in_or_create_google_user(body)
  end

  def test
    render json: @current_user
  end

  private

  def google_login_params
    params.require(:credentials).permit(:access_token)
  end

  def sign_in_or_create_google_user(user_details)
    user = User.where(email: user_details[:email]).first
    user || user = User.create(user_details)
    token = jwt_encode({ user_id: user.id, iat: DateTime.now.to_i })
    { user:, token: }
  end
end
