class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nombre, :string
    add_column :users, :apellido, :string
    add_column :users, :dni, :string
    add_column :users, :tipo_de_usuario, :string
    add_column :users, :telefono, :string
  end
end
