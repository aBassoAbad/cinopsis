class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :nombre_lista
      t.integer :usuario_id
      t.timestamps
    end
  end
end
