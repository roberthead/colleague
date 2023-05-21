class AddPronounsToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :preferred_pronouns, :string, null: false, default: ""
  end
end
