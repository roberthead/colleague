class AddPhoneNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string, null: false, default: "", limit: 30
  end
end
