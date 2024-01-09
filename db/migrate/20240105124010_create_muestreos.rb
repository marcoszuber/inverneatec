class CreateMuestreos < ActiveRecord::Migration[7.0]
  def change
    create_table :muestreos do |t|

      t.timestamps
    end
  end
end
