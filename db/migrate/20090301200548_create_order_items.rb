class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.string :status
      t.integer :order_id, :quantity, :product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
