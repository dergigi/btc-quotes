# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "google_drive"

session = GoogleDrive::Session.from_service_account_key("client_secret.json")
ws = session.spreadsheet_by_title("Bitcoin Resources").worksheets[1]

p ws[2,1]
