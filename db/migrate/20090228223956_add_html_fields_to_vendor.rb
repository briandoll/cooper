class AddHtmlFieldsToVendor < ActiveRecord::Migration
  def self.up
    add_column :vendors, :description_html, :string
    add_column :vendors, :contact_info_html, :string
  end

  def self.down
    remove_column :vendors, :description_html
    remove_column :vendors, :contact_info_html
  end
end
