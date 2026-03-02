class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments, id: :uuid do |t|
      t.decimal :amount
      t.string :currency
      t.string :payment_type
      t.string :status
      t.decimal :amount_charged
      t.string :provider_references

      t.timestamps
    end
  end
end
