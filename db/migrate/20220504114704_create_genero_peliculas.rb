class CreateGeneroPeliculas < ActiveRecord::Migration[6.1]
  def change
    create_table :genero_peliculas do |t|
      t.integer :pelicula_id
      t.integer :genero_id
      t.timestamps
    end
  end
end
