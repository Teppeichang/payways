class RemoveCreditCardIdToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :credit_card_id, :integer
  end
end
