require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Capsens
  class Application < Rails::Application
    before_filter :login_from_cookie
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    def login_from_cookie
      return unless cookies[:auth_token] && !logged_in?
      user = User.find_by_remember_token(cookies[:auth_token])
      if user && user.remember_token?
        user.remember_me
        self.current_user = user
        cookies[:auth_token] = { :domain => "#{DOMAIN}", :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        flash[:notice] = "#{self.current_user.login}, you have logged in successfully"
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
