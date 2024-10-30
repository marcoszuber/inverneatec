class AddDefaultToTipoDeUsuarioInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :tipo_de_usuario, from: nil, to: ""
  end
end
