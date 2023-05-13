class CreateEmployers < ActiveRecord::Migration[7.0]
  def change
    create_table :employers do |t|
      t.belongs_to :resume, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.string :location, null: false, default: ""
      t.string :url, null: false, default: ""

      t.timestamps
    end
  end
end
