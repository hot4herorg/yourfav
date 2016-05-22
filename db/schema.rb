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

ActiveRecord::Schema.define(version: 20160522173203) do

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "galleries", ["user_id"], name: "index_galleries_on_user_id"

  create_table "gallery_videos", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position"
  end

  add_index "gallery_videos", ["gallery_id"], name: "index_gallery_videos_on_gallery_id"
  add_index "gallery_videos", ["video_id"], name: "index_gallery_videos_on_video_id"

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "embed_code"
    t.boolean  "ph_network"
    t.boolean  "enabled",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "stars", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thumbnails", force: :cascade do |t|
    t.string   "url"
    t.integer  "video_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "valid_status"
  end

  add_index "thumbnails", ["video_id"], name: "index_thumbnails_on_video_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "video_stars", force: :cascade do |t|
    t.integer  "video_id"
    t.integer  "star_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "video_stars", ["star_id"], name: "index_video_stars_on_star_id"
  add_index "video_stars", ["video_id"], name: "index_video_stars_on_video_id"

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.string   "key"
    t.string   "title"
    t.integer  "site_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "thumb_url"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "videos", ["cached_votes_down"], name: "index_videos_on_cached_votes_down"
  add_index "videos", ["cached_votes_score"], name: "index_videos_on_cached_votes_score"
  add_index "videos", ["cached_votes_total"], name: "index_videos_on_cached_votes_total"
  add_index "videos", ["cached_votes_up"], name: "index_videos_on_cached_votes_up"
  add_index "videos", ["cached_weighted_average"], name: "index_videos_on_cached_weighted_average"
  add_index "videos", ["cached_weighted_score"], name: "index_videos_on_cached_weighted_score"
  add_index "videos", ["cached_weighted_total"], name: "index_videos_on_cached_weighted_total"
  add_index "videos", ["site_id"], name: "index_videos_on_site_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
