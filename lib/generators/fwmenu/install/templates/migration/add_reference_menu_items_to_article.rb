class AddReference<%= file_name.camelize %>ItemsToArticle< ActiveRecord::Migration
  def change
  	add_reference :<%= file_name %>_items, :article, index: true
  end
end
