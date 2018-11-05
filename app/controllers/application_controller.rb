class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include Response
  include ExceptionHandler

  def authenticate
    return if authenticate_with_http_basic do |user, pass|
      User.find_by(email: user, password: pass)
    end

    head :unauthorized
  end
end
