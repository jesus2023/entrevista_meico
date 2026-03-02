module Payments
  module Providers
    class FastPayProvider < BaseProvider
      COMMISSION_RATE = 0.03

      def process(params)
        response = simulate_api_call

        return { error: response[:error] } if response[:error]

        amount = params[:amount].to_f
        amount_with_commission = amount + (amount * COMMISSION_RATE)

        {
          provider_reference: response[:charge_id],
          amount_charged: amount_with_commission
        }
      end

      private

      def simulate_api_call
        { status: "succeeded", charge_id: "123" }
      end
    end
  end
end