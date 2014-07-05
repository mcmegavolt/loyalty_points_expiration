class CreatePointLineItems < ActiveRecord::Migration
  def change
    create_table :point_line_items do |t|
      t.references :user
      t.integer :points
      t.string :source

      t.timestamps
    end
  end
end
