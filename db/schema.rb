# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160520170002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "radiance_team_id"
    t.string   "dire_team_id"
    t.string   "radiance_team_name",  default: "", null: false
    t.string   "dire_team_name",      default: "", null: false
    t.string   "winner"
    t.string   "loser"
    t.datetime "actual_time_started"
    t.datetime "scheduled_datetime"
    t.date     "scheduled_date"
    t.integer  "best_of"
    t.integer  "megagame_id"
    t.string   "resultboard_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "uid",                              null: false
    t.integer  "first_blood"
    t.string   "mode"
    t.string   "cluster"
    t.string   "match_type"
    t.string   "duration"
    t.integer  "likes"
    t.integer  "dislikes"
    t.text     "towers_status"
    t.text     "barracks_status"
  end

  add_index "games", ["megagame_id"], name: "index_games_on_megagame_id", using: :btree

  create_table "games_teams", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "team_id", null: false
  end

  add_index "games_teams", ["game_id"], name: "index_games_teams_on_game_id", using: :btree
  add_index "games_teams", ["team_id"], name: "index_games_teams_on_team_id", using: :btree

  create_table "matchplayers", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "uid"
    t.text     "hero"
    t.integer  "level"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "last_hits"
    t.integer  "denies"
    t.integer  "gold"
    t.integer  "gpm"
    t.integer  "xpm"
    t.string   "status"
    t.integer  "gold_spent"
    t.integer  "hero_damage"
    t.integer  "tower_damage"
    t.integer  "hero_healing"
    t.text     "items"
    t.integer  "slot"
    t.boolean  "radiant",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "matchplayers", ["game_id"], name: "index_matchplayers_on_game_id", using: :btree
  add_index "matchplayers", ["radiant"], name: "index_matchplayers_on_radiant", using: :btree
  add_index "matchplayers", ["uid"], name: "index_matchplayers_on_uid", using: :btree

  create_table "megagames", force: :cascade do |t|
    t.string   "home_team",    default: "", null: false
    t.string   "away_team",    default: "", null: false
    t.string   "home_team_id"
    t.string   "away_team_id"
    t.string   "winner",       default: "", null: false
    t.string   "loser",        default: "", null: false
    t.integer  "which_game"
    t.decimal  "pool"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "email",                   default: "",   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name",              default: "",   null: false
    t.string   "last_name",               default: "",   null: false
    t.string   "nick_name"
    t.integer  "steam_id"
    t.string   "main_role",               default: "",   null: false
    t.string   "minor_role",              default: "",   null: false
    t.string   "country"
    t.string   "region"
    t.boolean  "active",                  default: true, null: false
    t.integer  "fantasy_point",           default: 0,    null: false
    t.string   "dotabuff_url"
    t.decimal  "player_accumulated_pool", default: 0.0,  null: false
    t.string   "image_url"
    t.text     "summary"
    t.float    "avg_kda"
    t.float    "avg_gpm"
    t.float    "avg_xpm"
    t.float    "avg_kills"
    t.float    "avg_deaths"
    t.float    "avg_assists"
    t.string   "profile_url"
    t.string   "uid"
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree

  create_table "players_teams", id: false, force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "team_id",   null: false
  end

  add_index "players_teams", ["player_id"], name: "index_players_teams_on_player_id", using: :btree
  add_index "players_teams", ["team_id"], name: "index_players_teams_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",                  default: "",    null: false
    t.integer  "captain"
    t.integer  "carry"
    t.integer  "mid"
    t.integer  "offlane"
    t.integer  "support_four"
    t.integer  "support_five"
    t.integer  "score",                 default: 0,     null: false
    t.boolean  "seeking",               default: false, null: false
    t.string   "current_game_id"
    t.string   "dotabuff_url"
    t.decimal  "team_accumulated_pool", default: 0.0,   null: false
    t.integer  "logo_url"
    t.string   "founder"
    t.integer  "num_of_wins",           default: 0,     null: false
    t.integer  "num_of_loses",          default: 0,     null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_foreign_key "games", "megagames"
  add_foreign_key "matchplayers", "games"
end
