class CreateDocumentacions < ActiveRecord::Migration[7.2]
  def change
    create_table :documentacions do |t|
      t.string :titulo
      t.text :comentarios
      t.string :pdf
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
