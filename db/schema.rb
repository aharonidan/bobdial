# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180612223538) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "nadir_enabled"
  end

  create_table "bets", force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
    t.integer "score_a"
    t.integer "score_b"
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.index ["game_id"], name: "index_bets_on_game_id"
    t.index ["user_id", "game_id"], name: "index_bets_on_user_id_and_game_id", unique: true
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "team_a_id"
    t.integer "team_b_id"
    t.integer "score_a"
    t.integer "score_b"
    t.string "group"
    t.boolean "is_playoff"
    t.datetime "match_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stadium"
    t.boolean "not_editable"
    t.datetime "deadline"
    t.index ["team_a_id"], name: "index_games_on_team_a_id"
    t.index ["team_b_id"], name: "index_games_on_team_b_id"
  end

  create_table "reports", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.date "report_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stats", force: :cascade do |t|
    t.string "name"
    t.integer "num_of_groups"
    t.string "group_a"
    t.string "group_b"
    t.string "group_c"
    t.string "group_d"
    t.string "group_e"
    t.string "group_f"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.boolean "black_horse"
    t.boolean "grey_horse"
    t.string "after_army_trip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_stats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "stat_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stat_id"], name: "index_user_stats_on_stat_id"
    t.index ["user_id"], name: "index_user_stats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "is_admin"
    t.string "after_army_trip"
    t.string "top_scorer"
    t.integer "points"
    t.integer "black_horse_id"
    t.integer "grey_horse_id"
    t.integer "champion_id"
    t.integer "account_id"
    t.index ["account_id"], name: "index_users_on_account_id"
  end

end
