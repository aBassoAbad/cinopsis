class CreatePersonaPeliculas < ActiveRecord::Migration[6.1]
  def change
    create_table :persona_peliculas do |t|
      t.integer :pelicula_id
      t.integer :persona_id
      t.timestamps
    end
  end
end
