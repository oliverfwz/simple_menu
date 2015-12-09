class Create<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
      t.string   "title"
      t.text     "description"
      t.string   "position"  
      t.string   "page"  
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end