class RemoveEmoneyIdToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :e_money_id, :integer
  end
end
