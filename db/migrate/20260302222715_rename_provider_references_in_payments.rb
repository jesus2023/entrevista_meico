class RenameProviderReferencesInPayments < ActiveRecord::Migration[8.1]
  def change
    rename_column :payments, :provider_references, :provider_reference
  end
end
