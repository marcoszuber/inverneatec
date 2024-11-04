class RemovePdfFromDocumentacions < ActiveRecord::Migration[7.0]
  def change
    remove_column :documentacions, :pdf, :string
  end
end
