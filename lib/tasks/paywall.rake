namespace :paywall do
  desc "Create a paywall.link paywall"
  task create: :environment do
    require "uri"
    require "net/http"
    require "json"

    url = URI("https://lnpay.co/v1/paywall")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["X-Api-Key"] = ENV["PAYWALL_API_KEY"]
    request["Content-Type"] = "application/json"
    request["Cookie"] = "_csrf=e8368322adc24c027c8169044bd2fba8af66110ff864142d30fa8b8b8a25433ba%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%22KWMjN_VATxvEARRFMymJzs_2EOrcFCWF%22%3B%7D"

    Quote.all.each do |q|
      memo = "Pay 2¢ to "
      memo += "listen to the original recording of this quote " if q.audio?
      memo += "see the source document of this quote " unless q.audio?
      memo += "by " + q.author.name

      request.body = <<-REQUEST
        {
          "destination_url": "#{q.source}",
          "memo": "#{memo}",
          "num_satoshis": 299,
          "link_rule_exp_id": "1_D"
        }
      REQUEST

      puts request.body

      response = https.request(request)
      puts response.read_body

      if response.code == "201"
        result = JSON.parse(response.body)
        q.paywall_link = result["paywall_link"]
        q.save!
        puts "[OK] " + q.source + " -> " + q.paywall_link
      else
        puts "[ERROR] Error creating paywall."
        puts response.inspect
      end
    end
  end

end
