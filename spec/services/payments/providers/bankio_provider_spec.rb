require 'rails_helper'

RSpec.describe Payments::Providers::BankioProvider do
  describe '#process' do
    let(:provider) { described_class.new }
    let(:params) { { amount: 1000 } }

    it 'returns provider_reference and amount_charged with fixed commission' do
      result = provider.process(params)

      expect(result[:provider_reference]).to eq("ABC-999")
      expect(result[:amount_charged]).to eq(1002.5)
    end
  end
end