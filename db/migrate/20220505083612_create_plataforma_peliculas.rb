class CreatePlataformaPeliculas < ActiveRecord::Migration[6.1]
  def change
    create_table :plataforma_peliculas do |t|
      t.integer :plataforma_id
      t.integer :pelicula_id
      t.timestamps
    end
  end
end
