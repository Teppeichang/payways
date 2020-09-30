class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shop_name, null: false
      t.text :explain
      t.timestamps
    end
  end
end
