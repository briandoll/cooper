require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  should_have_db_column :name, :type => "string", :default => nil
  
end
