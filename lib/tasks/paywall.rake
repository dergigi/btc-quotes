
namespace :paywall do
  desc "Create a paywall.link paywall"
  task create: :environment do |task, args|
    Quote.all.each do |q|
      q.create_paywall
    end
  end

end
