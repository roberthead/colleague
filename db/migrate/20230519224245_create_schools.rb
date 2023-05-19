class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.belongs_to :resume, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.string :location, null: false, default: ""
      t.string :url, null: false, default: ""
      t.string :major, null: false, default: ""
      t.string :degree, null: false, default: ""
      t.string :note, null: false, default: ""

      t.timestamps
    end
  end
end
