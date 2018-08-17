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

ActiveRecord::Schema.define(version: 2018_08_16_200424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "btree_gist"
  enable_extension "citext"
  enable_extension "cube"
  enable_extension "dblink"
  enable_extension "dict_int"
  enable_extension "dict_xsyn"
  enable_extension "earthdistance"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "intarray"
  enable_extension "ltree"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "pgrowlocks"
  enable_extension "pgstattuple"
  enable_extension "plpgsql"
  enable_extension "plv8"
  enable_extension "tablefunc"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"
  enable_extension "xml2"

  create_table "answers", force: :cascade do |t|
    t.string "text"
    t.bigint "challenge_id"
    t.integer "impact"
    t.integer "cost"
    t.boolean "selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_answers_on_challenge_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "problem"
    t.integer "time"
    t.boolean "completed"
    t.string "mode"
    t.boolean "impact_flag"
    t.boolean "cost_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extra_times", force: :cascade do |t|
    t.integer "time"
    t.bigint "challenge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_extra_times_on_challenge_id"
  end

  add_foreign_key "answers", "challenges"
  add_foreign_key "extra_times", "challenges"
end
