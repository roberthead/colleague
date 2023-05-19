class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.belongs_to :employer, null: false, foreign_key: true
      t.integer :start_year, null: false
      t.integer :end_year
      t.string :title, null: false
      t.text :accomplishments, null: false, default: ""

      t.timestamps
    end
  end
end
