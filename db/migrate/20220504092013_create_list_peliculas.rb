class CreateListPeliculas < ActiveRecord::Migration[6.1]
  def change
    create_table :list_peliculas do |t|
      t.integer :pelicula_id
      t.integer :list_id
      t.date :fecha_vista
      t.integer :temporada
      t.integer :episodio
      t.string :tipo
      t.timestamps
    end
  end
end
