class RenameProfileToSummaryOnResumes < ActiveRecord::Migration[7.0]
  def change
    rename_column :resumes, :profile, :summary
  end
end
