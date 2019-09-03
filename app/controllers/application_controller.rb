class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_last, if: proc { user_signed_in? && (session[:last] == nil || session[:last] < 20.minutes.ago) }

  def remote_ip
    if Rails.env.production?
      request.remote_ip
    else
      Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    end
  end
  private

  def set_last
    current_user.update_attribute(:last, Time.current)
    session[:last] = Time.current
  end
end
