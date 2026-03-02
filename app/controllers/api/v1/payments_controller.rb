class Api::V1::PaymentsController < ApplicationController

  def create
    processor = Paymments::PaymentProcessor.new(payment_params)
    result = processor.call

    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
    rescue StandardError => e
      render json: { error: "error: "Internal error"" }, status: :internal_server_error
  end

  private
    def payment_params
        params.require(:payment).permit(:amount, :currency, :payment_type)
    end
end
