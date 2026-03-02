class Payment < ApplicationRecord
  validates :amount, :currency, :payment_type, presence: true

  enum :status, {
    approved: "approved",
    rejected: "rejected"
  }

  after_initialize do
    self.status ||= "approved"
  end
end
