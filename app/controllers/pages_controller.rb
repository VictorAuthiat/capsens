class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if Rails.env.production?
      @ip = current_user.last_sign_in_ip
    else
      @ip = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    end
  end
  def dashboard
  end
end
