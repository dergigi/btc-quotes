namespace :paywall do
  desc "Create a paywall.link paywall"
  task :create => :environment do
    require "uri"
    require "net/http"

    url = URI("https://lnpay.co/v1/paywall")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["X-Api-Key"] = ENV["PAYWALL_API_KEY"]
    request["Content-Type"] = "application/json"
    request["Cookie"] = "_csrf=e8368322adc24c027c8169044bd2fba8af66110ff864142d30fa8b8b8a25433ba%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%22KWMjN_VATxvEARRFMymJzs_2EOrcFCWF%22%3B%7D"

    Quote.all.each do |q|
      source = q.source
      puts source
    end
    request.body = "{\n  \"destination_url\": \"https://www.dergigi.com\",\n  \"memo\": \"Paying this redirects to dergigi.com too\",\n  \"num_satoshis\": 13\n}"

    # response = https.request(request)
    # puts response.read_body
  end
end
