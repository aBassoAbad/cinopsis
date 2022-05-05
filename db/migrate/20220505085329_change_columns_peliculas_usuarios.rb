class ChangeColumnsPeliculasUsuarios < ActiveRecord::Migration[6.1]
  def change
    add_column :usuarios, :foto, :string
    add_column :peliculas, :tipo, :string
  end
end
