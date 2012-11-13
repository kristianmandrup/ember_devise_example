if defined?(Konacha)
  require 'capybara/poltergeist'
  Konacha.configure do |config|
    config.spec_dir    = "test/spec/javascripts"
    config.driver      = :poltergeist
    config.stylesheets = %w(application)
  end
end