class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :print_user_details
  after_action  :print_user_details
  include SessionsHelper

  def redirect_to_login
    redirect_to login_path
  end

  def print_user_details
  	if current_user
  		puts '-'*80
	  	puts current_user.name
	  	puts self.class.to_s + "." + self.action_name
	  	puts '-'*80
	  end
  end
end
