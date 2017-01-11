require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Armt
  class Application < Rails::Application
  	config.active_job.queue_adapter = :sidekiq

    config.action_mailer.delivery_method = :sendmail
		# Defaults to:
		# config.action_mailer.sendmail_settings = {
		#   location: '/usr/sbin/sendmail',
		#   arguments: '-i'
		# }
		config.action_mailer.perform_deliveries = true
		config.action_mailer.raise_delivery_errors = true
		config.action_mailer.default_options = {from: 'no-reply@example.com'}

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
