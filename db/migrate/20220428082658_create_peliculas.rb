class CreatePeliculas < ActiveRecord::Migration[6.1]
  def change
    create_table :peliculas do |t|
      t.string :nombre
      t.date :fecha_estreno
      t.text :sinopsis
      t.string :poster
      t.timestamps
    end
  end
end
