class AnadirIdTmdb < ActiveRecord::Migration[6.1]
  def change
    add_column :peliculas, :id_tmdb, :integer
  end
end
