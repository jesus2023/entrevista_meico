module Payments
  class ProviderFactory
    def self.build(payment_type)
      case payment_type
      when "credit_card"
        Providers::FastPayProvider.new
      when "bank_transfer"
        Providers::BankioProvider.new
      else
        raise "Unsupported payment type"
      end
    end
  end
end