# db/migrate/xxxxxx_change_gdpv_and_porcentaje_capitalizador_to_text_in_contratos.rb
class ChangeGdpvAndPorcentajeCapitalizadorToTextInContratos < ActiveRecord::Migration[6.0]
  def change
    change_column :contratos, :gdpv, :text
    change_column :contratos, :porcentaje_capitalizador, :text
  end
end
