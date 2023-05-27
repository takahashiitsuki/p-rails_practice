class ApplicationController < ActionController::Base
rescue_from LoginFailed, with: :login_failed
  
  def login_failed
    rendetr template: "shared/login_failed", status: 401
  end
  
  before_action do
    redirect_to access_denied_path if params[:token].blank?
  end
end
