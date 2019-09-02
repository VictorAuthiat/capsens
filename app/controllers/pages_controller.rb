class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @ip = remote_ip()
    if current_user
      current_user.ip = @ip
      current_user.save
    end
  end
end
