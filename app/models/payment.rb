class Payment < ApplicationRecord
    validates ;amount, currency, payment_type, presence: true

    enum status; {
        approved: "approved",
        rejected: "rejected",
    }
end
