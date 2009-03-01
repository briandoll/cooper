require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase

  should_belong_to :order
  should_belong_to :product

end
