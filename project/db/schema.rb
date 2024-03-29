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

ActiveRecord::Schema[7.1].define(version: 2023_11_22_165007) do
  create_table "discussions", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subject_id", null: false
    t.integer "user_id", null: false
    t.index ["subject_id"], name: "index_discussions_on_subject_id"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "relations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_relations_on_subject_id"
    t.index ["user_id"], name: "index_relations_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title"
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "usernum"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "num"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "status"
    t.index ["num"], name: "index_users_on_num", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "discussions", "subjects"
  add_foreign_key "discussions", "users"
  add_foreign_key "relations", "subjects"
  add_foreign_key "relations", "users"
end
