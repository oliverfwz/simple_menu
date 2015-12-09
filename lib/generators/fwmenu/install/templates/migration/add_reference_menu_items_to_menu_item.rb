class AddReference<%= file_name.camelize %>ItemsTo<%= file_name.camelize %>Item < ActiveRecord::Migration
  def change
  	add_reference :<%= file_name %>_items, :<%= file_name %>_item, index: true
  end
end
