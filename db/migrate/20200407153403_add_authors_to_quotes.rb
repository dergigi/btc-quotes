class AddAuthorsToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :author, :quotes
  end
end
