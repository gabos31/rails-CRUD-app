require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  self.use_instantiated_fixtures = true

  # Add more helper methods to be used by all tests here...
  def auth_user_0
    post session_url, params: { session: { email: 'admin@admin.com', password: 'admin' } }
  end

  def auth_user_1
    post session_url, params: { session: { email: 'linus@admin.com', password: 'admin1' } }
  end
end
