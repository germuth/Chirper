class AddPictureToChirps < ActiveRecord::Migration
  def change
    add_column :chirps, :picture, :string
  end
end
