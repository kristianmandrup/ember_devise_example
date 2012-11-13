ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
# DatabaseCleaner.strategy = :truncation, {:except => %w[<table names>]}

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end

# helpers for logging in & out
class ActionDispatch::IntegrationTest
  def sign_in(username, password)
    visit(new_user_session_path)
    fill_in('Email', :with => username)
    fill_in('Password', :with => password)
    click_button('Sign in')
  end

  def sign_out
    visit(destroy_user_session_path)
  end

  def signInEmber(username, password)
    visit('/#/signIn')
    fill_in('email', :with => username)
    fill_in('password', :with => password)
    click_button('Sign In')
  end

#  def signOutEmber(username, password)
#    visit(new_user_session_path)
#    fill_in('Email', :with => username)
#    fill_in('Password', :with => password)
#    click_button('Sign in')
#  end

end
