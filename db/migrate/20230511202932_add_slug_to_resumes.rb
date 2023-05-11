class AddSlugToResumes < ActiveRecord::Migration[7.0]
  def change
    add_column :resumes, :slug, :string, null: false, default: ""
  end
end
