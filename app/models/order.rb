class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :order_items
  
  STATUS_COMPLETE  = 2
  STATUS_SUBMITTED = 1
  STATUS_OPEN      = 0
  STATUS = {STATUS_OPEN => "Open", STATUS_SUBMITTED => "Submitted", STATUS_COMPLETE => "Complete"}
  
  def self.create(user)
    order = self.new do |o|
      o.user   = user
      o.status = STATUS_OPEN
    end
    order.save
    order
  end
  
  def status
    STATUS[super]
  end
  
  def open?
    STATUS[STATUS_OPEN].eql? status
  end

  def submitted?
    STATUS[STATUS_SUBMITTED].eql? status
  end

  def complete?
    STATUS[STATUS_COMPLETE].eql? status
  end
  
  def items
    order_items
  end
  
  def add_item(product, quantity)
    if status.eql? STATUS[STATUS_OPEN]
      order_item = OrderItem.find_by_order_id_and_product_id(id, product.id)
      if order_item
        order_item.quantity += quantity
      else
        order_item = OrderItem.create(self, product, quantity)
      end
      order_item.save
    else
      raise "You may not add items to this order, as its status is #{status}"
    end
  end
  
  def self.open_orders
    self.find_all_by_status(STATUS_OPEN)
  end
  
  def self.submitted_orders
    self.find_all_by_status(STATUS_SUBMITTED)
  end
  
  def self.completed_orders
    self.find_all_by_status(STATUS_COMPLETE)
  end
  
end
