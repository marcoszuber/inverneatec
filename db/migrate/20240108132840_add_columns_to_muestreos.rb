class AddColumnsToMuestreos < ActiveRecord::Migration[7.0]
  def change
    add_column :muestreos, :peso, :decimal
    add_column :muestreos, :gdm, :string
    add_column :muestreos, :notas_sobre_el_animal, :text
    add_column :muestreos, :ide, :string
    add_column :muestreos, :origen, :string
    add_column :muestreos, :sexo, :string
    add_column :muestreos, :tropa, :string
    add_column :muestreos, :gdm_total, :decimal
    add_column :muestreos, :gpv, :decimal
    add_column :muestreos, :gpv_total, :decimal
    add_column :muestreos, :dias, :integer
    add_column :muestreos, :total_de_dias, :integer
    add_column :muestreos, :destino, :string
    add_column :muestreos, :fecha, :date
    add_column :muestreos, :hora, :time
  end
end
