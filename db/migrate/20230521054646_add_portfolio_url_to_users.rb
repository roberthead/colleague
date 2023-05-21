class AddPortfolioUrlToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :portfolio_url, :string, null: false, default: ""
  end
end
