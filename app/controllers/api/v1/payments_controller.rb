class Api::V1::PaymentsController < ApplicationController
  def create
    processor = Payments::PaymentProcessor.new(payment_params)
    result = processor.call

    if result.success?
      render json: result.data, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  rescue => e
    render json: { errors: ["Internal error"] }, status: :internal_server_error
  end

  private

  def payment_params
    params.permit(:amount, :currency, :payment_type, details: {})
  end
end