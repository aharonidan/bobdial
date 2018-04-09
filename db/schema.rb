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

ActiveRecord::Schema.define(version: 20180409143110) do

  create_table "bets", force: :cascade do |t|
    t.integer "game_id"
    t.integer "user_id"
    t.integer "team_a_score"
    t.integer "team_b_score"
    t.string "group_or_phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["team_a_id"], name: "index_games_on_team_a_id"
    t.index ["team_b_id"], name: "index_games_on_team_b_id"
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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "is_admin"
  end

end
