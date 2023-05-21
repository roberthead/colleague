# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_21_050002) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employers", force: :cascade do |t|
    t.bigint "resume_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "location", default: "", null: false
    t.string "url", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resume_id"], name: "index_employers_on_resume_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "field", default: "", null: false
    t.text "profile", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "alias_name", limit: 80, default: "", null: false
    t.string "email", limit: 80, default: "", null: false
    t.string "phone", limit: 30, default: "", null: false
    t.string "slug", default: "", null: false
    t.index ["user_id"], name: "index_resumes_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "employer_id", null: false
    t.integer "start_year", null: false
    t.integer "end_year"
    t.string "title", null: false
    t.text "accomplishments", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employer_id"], name: "index_roles_on_employer_id"
  end

  create_table "schools", force: :cascade do |t|
    t.bigint "resume_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.string "location", default: "", null: false
    t.string "url", default: "", null: false
    t.string "major", default: "", null: false
    t.string "degree", default: "", null: false
    t.string "note", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resume_id"], name: "index_schools_on_resume_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "name", default: "", null: false
    t.string "phone", limit: 30, default: "", null: false
    t.string "preferred_pronouns", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "employers", "resumes"
  add_foreign_key "resumes", "users"
  add_foreign_key "roles", "employers"
  add_foreign_key "schools", "resumes"
end
