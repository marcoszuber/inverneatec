class CreatePrecios < ActiveRecord::Migration[7.0]
  def change
    create_table :precios do |t|
      t.string :categoria
      t.string :max_precio
      t.string :prom_precio
      t.string :min_precio
      t.string :cantidad_cab

      t.timestamps
    end
  end
end
