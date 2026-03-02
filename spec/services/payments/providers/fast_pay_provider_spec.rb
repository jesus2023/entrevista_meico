require 'rails_helper'

RSpec.describe Payments::Providers::FastPayProvider do
  describe '#process' do
    let(:provider) { described_class.new }
    let(:params) { { amount: 1000 } }

    it 'returns provider_reference and amount_charged with 3% commission' do
      result = provider.process(params)

      expect(result[:provider_reference]).to eq("123")
      expect(result[:amount_charged]).to eq(1030.0)
    end
  end
end