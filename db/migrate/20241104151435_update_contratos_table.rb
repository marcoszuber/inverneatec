class UpdateContratosTable < ActiveRecord::Migration[7.2]
  def change
    add_column :contratos, :titulo, :string
    add_column :contratos, :provincia, :string
    add_column :contratos, :localidad, :string
    add_column :contratos, :coordenadas, :string
    add_column :contratos, :referencias_geograficas, :text
    add_column :contratos, :superficie_total, :float
    add_column :contratos, :superficie_apta_uso, :float
    add_column :contratos, :descripcion_establecimiento, :text
  end
end
