class ChangeStatusToInteger < ActiveRecord::Migration
  def self.up
    remove_column :orders, :status
    remove_column :order_items, :status
    add_column :orders, :status, :integer
    add_column :order_items, :status, :integer
  end

  def self.down
    remove_column :orders, :status
    remove_column :order_items, :status
    add_column :orders, :status, :string
    add_column :order_items, :status, :string
  end
end
