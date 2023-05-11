class AddContactInfoToResumes < ActiveRecord::Migration[7.0]
  def change
    change_table :resumes, bulk: true do |t|
      t.column :alias_name, :string, null: false, default: "", limit: 80
      t.column :email, :string, null: false, default: "", limit: 80
      t.column :phone, :string, null: false, default: "", limit: 30
    end
  end
end
