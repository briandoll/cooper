class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :category_id, :vendor_id
      t.float   :unit_price, :null => false
      t.string  :description, :name, :null => false
      t.integer :status, :product_type, :default => 0, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
