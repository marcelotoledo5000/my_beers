require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module MyBeers
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
  end
end
