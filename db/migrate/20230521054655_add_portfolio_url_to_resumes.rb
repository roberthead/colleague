class AddPortfolioUrlToResumes < ActiveRecord::Migration[7.0]
  def change
    add_column :resumes, :portfolio_url, :string, null: false, default: ""
  end
end
