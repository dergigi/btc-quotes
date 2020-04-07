class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.text :body
      t.string :source
      t.date :date
      t.boolean :audio

      t.references :author, index: true

      t.timestamps
    end
  end
end
