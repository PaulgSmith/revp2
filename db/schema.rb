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

ActiveRecord::Schema[7.0].define(version: 2023_04_02_000328) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "salary", precision: 10, scale: 2, null: false
  end

  create_table "login_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.string "personnel_id", null: false
  end

  create_table "personnels", force: :cascade do |t|
    t.string "username", null: false
    t.string "pass", null: false
    t.string "name", null: false
    t.string "title", null: false
  end

  create_table "reimbursement_requests", force: :cascade do |t|
    t.integer "personnel_id", null: false
    t.decimal "request_amount", precision: 10, scale: 2, null: false
    t.string "subject", null: false
    t.string "request"
    t.integer "status", default: 0, null: false
    t.integer "manager_id"
    t.string "manager_comment"
  end

end
