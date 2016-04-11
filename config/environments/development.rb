ConnectMed::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

   # Mailer configuration using Gmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = {from: 'no-reply@connectmed.co.za'}
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host:'localhost', port: '3000' }
  config.action_mailer.smtp_settings = {
    :port => 587,
    :address => 'smtp.sendgrid.net',
    :user_name => Figaro.env.sendgrid_username,
    :password => Figaro.env.sendgrid_password,
    :domain => 'connectmed.co.za',
    :authentication => :plain,
    :enable_starttls_auto => true
  }


  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # For using paperclip in development
  Paperclip.options[:command_path] = "/usr/local/bin/"

end
