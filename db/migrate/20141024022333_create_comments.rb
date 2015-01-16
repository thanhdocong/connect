class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :entry
      t.references :user
      t.timestamps
    end
    add_index :comments, [:id]
    add_index :comments, [:user_id,:created_at]
  end
end
