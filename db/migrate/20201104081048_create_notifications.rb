class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.string :action
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
