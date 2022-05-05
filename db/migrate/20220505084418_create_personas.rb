class CreatePersonas < ActiveRecord::Migration[6.1]
  def change
    create_table :personas do |t|
      t.string :nombre
      t.string :departamento
      t.text :biografía
      t.date :fecha_nac
      t.date :fecha_fall
      t.string :nacionalidad
      t.string :foto
      t.timestamps
    end
  end
end
