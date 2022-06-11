class DropTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :generos
    drop_table :plataformas
    drop_table :personas
    drop_table :genero_peliculas
    drop_table :plataforma_peliculas
    drop_table :persona_peliculas
  end
end
