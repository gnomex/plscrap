require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Plscrap
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.available_locales = [:"pt-BR"]
    config.i18n.default_locale = :"pt-BR"
    config.time_zone = 'Brasilia'
    config.encoding = "utf-8"

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get]
      end
    end
  end
end
