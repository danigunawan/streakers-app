class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include DeviseWhitelist
  acts_as_token_authentication_handler_for User, fallback: :none
end
