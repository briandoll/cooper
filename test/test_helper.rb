ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'factory_girl'
require 'shoulda'
require 'factories'

class Test::Unit::TestCase
  fixtures :users
  include AuthenticatedTestHelper
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end
