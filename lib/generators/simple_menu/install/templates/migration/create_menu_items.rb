class CreateMenuItems < ActiveRecord::Migration
  def up
    create_table :menu_items do |t|
      t.string     "title"
      t.string     "link"
      t.string     "page"
      t.string     "target", default: "_self"  
      t.integer    "ordering", default: 1
      t.string     "show"
      t.integer    "level", default: 1
      t.boolean    "internal_link", default: true
      t.boolean    "published", default: true
      t.string     "sort_tree"
      t.timestamps
      t.references :menu
    end

    add_index :menu_items, :menu_id
  end

  def down
    drop_table :menu_items
  end
end