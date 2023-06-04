class ApplicationController < ActionController::Base
rescue_from LoginFailed, with: :login_failed
before_action :detect_mobile_variant
  
  def login_failed
    rendetr template: "shared/login_failed", status: 401
  end
  
  before_action do
    redirect_to access_denied_path if params[:token].blank?
  end
  
  private
  def detect_mobile_variant
    request.variant = :mobile if request.user_agent =~ /iPhone/
  end
end
