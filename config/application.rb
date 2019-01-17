require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QuantCo
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    BusinessTime::Config.holidays = [
      Date.new(2016, 1, 1), Date.new(2016, 2, 9), Date.new(2016, 3, 25),
      Date.new(2016, 3, 27), Date.new(2016, 4, 21), Date.new(2016, 5, 1),
      Date.new(2016, 5, 26), Date.new(2016, 9, 7), Date.new(2016, 10, 12),
      Date.new(2016, 11, 2), Date.new(2016, 11, 15), Date.new(2016, 12, 25),

      Date.new(2017, 1, 1), Date.new(2017, 2, 28), Date.new(2017, 4, 14),
      Date.new(2017, 4, 16), Date.new(2017, 4, 21), Date.new(2017, 5, 1),
      Date.new(2017, 6, 1), Date.new(2017, 9, 7), Date.new(2017, 10, 12),
      Date.new(2017, 11, 2), Date.new(2017, 11, 15), Date.new(2017, 12, 25)
    ]
  end
end
