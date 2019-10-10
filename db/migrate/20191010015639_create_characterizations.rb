class CreateCharacterizations < ActiveRecord::Migration[5.1]
  def change
    create_table :characterizations do |t|
      t.references :movie
      t.references :genre

      t.timestamps
    end
  end
end
