class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :author
      t.text :body
      t.string :source
      t.date :date
      t.boolean :audio

      t.timestamps
    end
  end
end
