class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body      
      t.belongs_to :post, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
    add_index :comments, [:post_id, :user_id, :created_at]
  end
end
