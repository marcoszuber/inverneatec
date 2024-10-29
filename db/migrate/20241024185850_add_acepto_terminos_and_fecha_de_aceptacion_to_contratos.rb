class AddAceptoTerminosAndFechaDeAceptacionToContratos < ActiveRecord::Migration[7.0]
  def change
    add_column :contratos, :acepto_terminos, :boolean
    add_column :contratos, :fecha_de_aceptacion, :datetime
  end
end
