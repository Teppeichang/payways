class RemoveCodePayIdToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :code_pay_id, :integer
  end
end
