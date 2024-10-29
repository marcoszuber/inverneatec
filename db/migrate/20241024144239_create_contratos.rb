class CreateContratos < ActiveRecord::Migration[7.0]
  def change
    create_table :contratos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :campo

      t.timestamps
    end
  end
end
