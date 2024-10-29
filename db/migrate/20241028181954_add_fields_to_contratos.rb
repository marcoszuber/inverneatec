class AddFieldsToContratos < ActiveRecord::Migration[7.0]
  def change
    add_column :contratos, :fecha, :date
    add_column :contratos, :capitalizador, :string
    add_column :contratos, :capitalista, :string
    add_column :contratos, :vigencia_inicio, :date
    add_column :contratos, :vigencia_fin, :date
    add_column :contratos, :prorroga, :boolean
    add_column :contratos, :obligaciones_capitalizador, :text
    add_column :contratos, :obligaciones_capitalista, :text
    add_column :contratos, :mortandad_tolerada, :float
    add_column :contratos, :mortandad_excedida, :float
    add_column :contratos, :encierre, :boolean
    add_column :contratos, :frecuencia_pesaje, :string
    add_column :contratos, :porcentaje_pesaje, :float
    add_column :contratos, :desbaste, :float
    add_column :contratos, :gdpv, :float
    add_column :contratos, :porcentaje_capitalizador, :float
    add_column :contratos, :forma_cancelacion, :string
  end
end
