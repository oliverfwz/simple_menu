class AddReference<%= file_name.camelize %>ItemsToCategory < ActiveRecord::Migration
  def change
  	add_reference :<%= file_name %>_items, :category, index: true
  end
end