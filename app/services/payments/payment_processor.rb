require 'ostruct'

module Payments
  class PaymentProcessor
    def initialize(params)
      @params = params
    end

    def call
      provider = ProviderFactory.build(@params[:payment_type])
      response = provider.process(@params)

      return failure(response[:error]) if response[:error]

      payment = Payment.create!(
        amount: @params[:amount],
        currency: @params[:currency],
        payment_type: @params[:payment_type],
        status: "approved",
        amount_charged: response[:amount_charged],
        provider_reference: response[:provider_reference]
      )

      success(payment)
    rescue => e
      failure(e.message)
    end

    private

    def success(payment)
      OpenStruct.new(
        success?: true,
        data: {
          id: payment.id,
          status: payment.status,
          amount_charged: payment.amount_charged.to_f,
          provider_reference: payment.provider_reference
        },
        errors: []
      )
    end

    def failure(message)
      OpenStruct.new(
        success?: false,
        data: nil,
        errors: [message]
      )
    end
  end
end