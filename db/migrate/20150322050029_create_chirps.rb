class CreateChirps < ActiveRecord::Migration
  def change
    create_table :chirps do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :chirps, :users
		add_index :chirps, [:user_id, :created_at]
  end
end
