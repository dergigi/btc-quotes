# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "google_drive"
require "date"

session = GoogleDrive::Session.from_service_account_key("google-credentials.json")
ws = session.spreadsheet_by_title("Bitcoin Resources").worksheets[1]

(2..ws.num_rows).each do |row| # skip first row (heading)
  author = Author.where(:name => ws[row, 1], :twitter => ws[row, 2]).first_or_create
  quote = Quote.create(body: ws[row, 3], source: ws[row, 4], date: Date.parse(ws[row, 5]), audio: ws[row, 6], author_id: author.id)
  p quote
end
