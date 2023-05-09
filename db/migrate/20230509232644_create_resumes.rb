class CreateResumes < ActiveRecord::Migration[7.0]
  def change
    create_table :resumes do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :field, null: false, default: ""
      t.text :profile, null: false, default: ""

      t.timestamps
    end
  end
end
