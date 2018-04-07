class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def redirect_to_root
    redirect_to root_path
  end
end
