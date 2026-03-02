module Payments
  module Providers
    class BaseProvider
      def process(params)
        raise NotImplementedError
      end
    end
  end
end