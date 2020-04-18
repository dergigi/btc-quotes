class Quote < ApplicationRecord
  belongs_to :author

  def memo
    memo = "Pay a couple sats to "
    memo += "listen to the original recording of this quote " if self.audio?
    memo += "see the source document of this quote " unless self.audio?
    memo += "by " + self.author.name

    return memo
  end

  def create_paywall
    if self.paywall_link.blank? || ENV["FORCE_PAYWALL"]
      self.paywall_link = ApplicationController.helpers.create_paywall_request(self.source, self.memo)
      self.save!
    else
      puts "Paywall already exists for Quote #{self.id} - set ENV or call with FORCE_PAYWALL=true to force creation and replace existing paywall link."
    end
  end
end
