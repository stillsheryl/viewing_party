class AddRunTimeToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :runtime, :Integer
  end
end
