require 'rails_helper'

RSpec.describe Payments::PaymentProcessor do
  describe '#call' do
    let(:params) do
      {
        amount: 1000,
        currency: "USD",
        payment_type: "credit_card"
      }
    end

    context 'when payment is successful' do
      it 'creates a payment and returns success' do
        result = described_class.new(params).call

        expect(result.success?).to be true
        expect(result.data[:status]).to eq("approved")
        expect(result.data[:amount_charged]).to eq(1030.0)
      end
    end

    context 'when provider returns error' do
      it 'does not create a payment and returns failure' do
        allow_any_instance_of(
          Payments::Providers::FastPayProvider
        ).to receive(:process).and_return({ error: "card_declined" })

        result = described_class.new(params).call

        expect(result.success?).to be false
        expect(result.errors).to include("card_declined")
        expect(Payment.count).to eq(0)
      end
    end
  end
end