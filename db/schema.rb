# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_27_094656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "state"
    t.integer "number"
    t.string "html_url"
    t.integer "comments_count"
    t.string "user"
    t.string "repo_full_name"
    t.datetime "closed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "org"
    t.string "collabs", default: [], array: true
    t.string "milestone_name"
    t.integer "milestone_id"
    t.string "labels", default: [], array: true
    t.boolean "locked"
    t.datetime "merged_at"
    t.boolean "draft"
    t.index ["collabs"], name: "index_issues_on_collabs", using: :gin
    t.index ["html_url"], name: "index_issues_on_html_url"
    t.index ["org"], name: "index_issues_on_org"
    t.index ["repo_full_name"], name: "index_issues_on_repo_full_name"
    t.index ["state"], name: "index_issues_on_state"
    t.index ["user"], name: "index_issues_on_user"
  end

  create_table "topics", force: :cascade do |t|
    t.integer "remote_id"
    t.string "title"
    t.integer "posts_count"
    t.boolean "closed"
    t.integer "views"
    t.boolean "has_accepted_answer"
    t.integer "like_count"
    t.string "username"
    t.integer "category_id"
    t.string "category_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
