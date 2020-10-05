class CreatePostTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tag_relations do |t|
      t.integer :post_id, foreign_key: true
      t.integer :tag_id, foreign_key: true
      t.timestamps
    end
  end
end
