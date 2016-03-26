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

ActiveRecord::Schema.define(version: 20160326203147) do

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
  end

  add_index "gallery_videos", ["gallery_id"], name: "index_gallery_videos_on_gallery_id"
  add_index "gallery_videos", ["video_id"], name: "index_gallery_videos_on_video_id"

  create_table "marks", force: :cascade do |t|
    t.integer  "marker_id"
    t.string   "marker_type"
    t.integer  "markable_id"
    t.string   "markable_type"
    t.string   "mark",          limit: 128
    t.datetime "created_at"
  end

  add_index "marks", ["markable_id", "markable_type", "mark"], name: "index_marks_on_markable_id_and_markable_type_and_mark"
  add_index "marks", ["marker_id", "marker_type", "mark"], name: "index_marks_on_marker_id_and_marker_type_and_mark"

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
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "thumb_url"
  end

  add_index "videos", ["site_id"], name: "index_videos_on_site_id"

end
