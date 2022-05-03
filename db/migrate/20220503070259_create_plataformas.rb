class CreatePlataformas < ActiveRecord::Migration[6.1]
  def change
    create_table :plataformas do |t|
      t.string :nombre
      t.string :foto
      t.timestamps
    end
  end
end
