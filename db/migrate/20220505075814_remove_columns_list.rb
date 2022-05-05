class RemoveColumnsList < ActiveRecord::Migration[6.1]
  def change
    remove_column :list_peliculas, :tipo
    remove_column :list_peliculas, :fecha_vista
    remove_column :list_peliculas, :temporada
    remove_column :list_peliculas, :episodio
  end
end