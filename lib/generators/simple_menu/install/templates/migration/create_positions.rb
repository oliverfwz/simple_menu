class CreatePositions < ActiveRecord::Migration
  def up
    create_table :positions do |t|
      t.string   "title"
    end
  end

  def down
    drop_table :positions
  end
end