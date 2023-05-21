class AddPronounsToResumes < ActiveRecord::Migration[7.0]
  def change
    add_column :resumes, :preferred_pronouns, :string, null: false, default: ""
  end
end
