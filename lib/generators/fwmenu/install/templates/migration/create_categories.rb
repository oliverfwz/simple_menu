class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string   "title"
      t.text     "description"
      t.string   "slug"
      t.string   "layout"    
      t.timestamps
    end

    add_index :categories, :slug, :unique => true
  end

  def self.down
    drop_table :categories
  end
end