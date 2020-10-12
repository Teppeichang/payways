class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prefecture_id, :integer
    add_column :users, :favorite_shop, :string
  end
end
