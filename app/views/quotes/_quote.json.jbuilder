json.extract! quote, :body, :paywall_link, :date
json.author do
  json.partial! "authors/author", author: quote.author
end
