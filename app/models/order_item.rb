class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  STATUS_ORDERED   = 0
  STATUS_CANCELLED = 1
  STATUS = {STATUS_ORDERED => "Ordered", STATUS_CANCELLED => "Cancelled"}

  def self.create(order, product, quantity) 
    item = self.new do |i|
      i.order = order
      i.product = product
      i.quantity = quantity
    end
    item    
  end

  def status
    STATUS[super] || order.status
  end
  
end
