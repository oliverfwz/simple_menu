class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string   "title"
      t.text     "short_description"
      t.text     "description"
      t.string   "slug"
      t.string   "layout"
      t.integer  "ordering", default: 1    
      t.timestamps
    end

    add_index :articles, :slug, :unique => true
  end

  def self.down
    drop_table :articles
  end
end