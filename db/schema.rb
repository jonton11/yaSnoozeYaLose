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

ActiveRecord::Schema.define(version: 20160619222230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenge_actions", force: :cascade do |t|
    t.integer  "challenge_id"
    t.integer  "user_id"
    t.integer  "streak_count", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "vote",         default: false
    t.date     "track_date"
    t.integer  "total_streak"
  end

  add_index "challenge_actions", ["challenge_id"], name: "index_challenge_actions_on_challenge_id", using: :btree
  add_index "challenge_actions", ["user_id"], name: "index_challenge_actions_on_user_id", using: :btree

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.integer  "team_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "aasm_state"
    t.string   "reward"
  end

  add_index "challenges", ["team_id"], name: "index_challenges_on_team_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["team_id"], name: "index_members_on_team_id", using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "streak_events", force: :cascade do |t|
    t.boolean  "on_streak"
    t.integer  "challenge_action_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "total_streak",        default: 0
  end

  add_index "streak_events", ["challenge_action_id"], name: "index_streak_events_on_challenge_action_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.text     "twitter_raw_data"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "facebook_token"
    t.string   "facebook_secret"
    t.text     "facebook_raw_data"
  end

  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", using: :btree

  add_foreign_key "challenge_actions", "challenges"
  add_foreign_key "challenge_actions", "users"
  add_foreign_key "challenges", "teams"
  add_foreign_key "members", "teams"
  add_foreign_key "members", "users"
  add_foreign_key "streak_events", "challenge_actions"
end
