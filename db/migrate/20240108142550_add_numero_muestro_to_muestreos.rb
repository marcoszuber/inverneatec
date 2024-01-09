class AddNumeroMuestroToMuestreos < ActiveRecord::Migration[7.0]
  def change
    add_column :muestreos, :numero_muestro, :string
  end
end
