module Payments
  module Providers
    class BankioProvider < BaseProvider
      FIXED_COMMISSION = 2.5

      def process(params)
        response = simulate_api_call

        return { error: response[:error] } if response[:error]
        return { error: "transaction_failed" } unless response[:transaction_state] == "processed"

        amount = params[:amount].to_f

        {
          provider_reference: response[:ref_code],
          amount_charged: amount + FIXED_COMMISSION
        }
      end

      private

      def simulate_api_call
        { transaction_state: "processed", ref_code: "ABC-999" }
      end
    end
  end
end