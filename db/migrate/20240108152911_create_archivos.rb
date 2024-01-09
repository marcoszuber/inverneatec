class CreateArchivos < ActiveRecord::Migration[7.0]
  def change
    create_table :archivos do |t|
      t.string :titulo
      t.text :descripcion
      t.text :notas

      t.timestamps
    end
    # Agregar la asociación con Muestreo
    add_reference :muestreos, :archivo, foreign_key: true
  end
end
