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

ActiveRecord::Schema.define(version: 20190515175450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "slug"
    t.string "notes"
    t.index ["user_id"], name: "index_brands_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent"
  end

  create_table "channel_users", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "channel_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_emails", force: :cascade do |t|
    t.string "email"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "primary", default: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "billing_address"
    t.string "shipping_address"
    t.string "phone"
    t.integer "brand_id"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.string "status"
    t.integer "manage_by"
    t.integer "owned_by"
    t.boolean "po_required"
    t.text "payment_terms"
    t.text "notes"
    t.string "website"
    t.decimal "balance"
    t.decimal "balance_total"
    t.string "bill_1"
    t.string "bill_2"
    t.string "bill_3"
    t.string "bill_4"
    t.string "bill_5"
    t.string "ship_1"
    t.string "ship_2"
    t.string "ship_3"
    t.string "ship_4"
    t.string "ship_5"
    t.string "terms"
    t.string "rep"
    t.string "sales_tax_code"
    t.string "tax_item"
    t.boolean "active", default: true
    t.string "fax"
  end

  create_table "default_attributes", force: :cascade do |t|
    t.string "field_name"
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "input_type"
  end

  create_table "default_templates", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "template_type"
  end

  create_table "default_works", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_shares", force: :cascade do |t|
    t.integer "document_upload_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
  end

  create_table "document_uploads", force: :cascade do |t|
    t.string "description"
    t.text "attachment_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "document_upload_id"
    t.integer "status", default: 0
    t.index ["document_upload_id"], name: "index_document_uploads_on_document_upload_id"
  end

  create_table "email_template_attachments", force: :cascade do |t|
    t.integer "email_template_id"
    t.string "attachment_file_file_name"
    t.string "attachment_file_content_type"
    t.integer "attachment_file_file_size"
    t.datetime "attachment_file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_template_order_entries", force: :cascade do |t|
    t.integer "email_template_id"
    t.integer "order_entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_template_users", force: :cascade do |t|
    t.integer "email_template_id"
    t.integer "user_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type"
  end

  create_table "email_templates", force: :cascade do |t|
    t.integer "order_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", id: :integer, default: nil, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.integer "brand_id"
    t.integer "shipping_address"
    t.integer "address_id"
    t.string "email"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_number"
    t.string "slug"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "loc_id"
    t.integer "bin_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "aisle_id"
    t.integer "product_id"
    t.integer "cartons"
  end

  create_table "inventory_details", force: :cascade do |t|
    t.integer "inventory_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_messages", force: :cascade do |t|
    t.text "body"
    t.text "attachment_data"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_entry_id"
    t.index ["order_entry_id"], name: "index_item_messages_on_order_entry_id"
    t.index ["user_id"], name: "index_item_messages_on_user_id"
  end

  create_table "mailboxer_conversation_opt_outs", id: :integer, default: nil, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :integer, default: nil, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_notifications", id: :integer, default: nil, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "global", default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notifications_notified_object"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :integer, default: nil, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delivered", default: false
    t.string "delivery_method"
    t.string "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.text "attachment_data"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chatroom_order_id"
    t.integer "channel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "office_time_logs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_attachments", force: :cascade do |t|
    t.integer "order_id"
    t.text "attachment_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_branches", force: :cascade do |t|
    t.integer "address_id"
    t.integer "brand_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hotel_id"
  end

  create_table "order_entries", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.decimal "price"
    t.decimal "cost"
    t.decimal "tax"
    t.integer "quoted_by"
    t.integer "quantity"
    t.integer "vendor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "status", default: 0
    t.string "dynamic_fields"
    t.text "specs"
    t.text "vendor_quote_prices"
    t.text "notes"
  end

  create_table "order_entry_attachments", force: :cascade do |t|
    t.integer "order_entry_id"
    t.string "attachment_file_file_name"
    t.string "attachment_file_content_type"
    t.integer "attachment_file_file_size"
    t.datetime "attachment_file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
  end

  create_table "order_entry_vendors", force: :cascade do |t|
    t.integer "order_entry_id"
    t.integer "vendor_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_histories", force: :cascade do |t|
    t.integer "order_id"
    t.integer "order_entry_id"
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
  end

  create_table "order_offices", force: :cascade do |t|
    t.integer "order_id"
    t.integer "office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
    t.decimal "amount"
    t.decimal "net_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.datetime "received_on"
    t.string "vc_code"
    t.string "mfg_code"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_users", force: :cascade do |t|
    t.integer "regional"
    t.integer "comms"
    t.integer "art"
    t.integer "processor"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_contact"
    t.integer "designer"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.string "notes"
    t.integer "supplier_id"
    t.decimal "total_amount"
    t.integer "status", default: 0
    t.string "invoice_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
  end

  create_table "patient_shared_files", force: :cascade do |t|
    t.integer "patient_id"
    t.text "attachment_data"
    t.string "notes_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.boolean "status", default: true
    t.string "full_name"
    t.string "mobile_no"
    t.boolean "confirmed", default: false
    t.string "authy_id"
    t.string "area_code"
    t.string "pin"
    t.string "token"
    t.integer "office_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true
  end

  create_table "product_accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_asset_accounts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_category_vendors", force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.integer "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_cogs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "approval_status"
    t.datetime "online_date"
    t.datetime "offline_date"
    t.string "unit"
    t.string "description"
    t.string "base_product"
    t.integer "category"
    t.decimal "price"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.string "variant_type"
    t.string "style"
    t.string "variants"
    t.boolean "force_in_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
    t.bigint "style_attribute_id"
    t.integer "item_category_id"
    t.text "image_data"
    t.string "dynamic_fields"
    t.text "specs"
    t.text "vendor_quote_prices"
    t.text "notes"
    t.decimal "cost", precision: 12, scale: 3
    t.boolean "active", default: true
    t.integer "product_type_id"
    t.boolean "sales_tax", default: true
    t.integer "product_account_id"
    t.string "product_cog_id"
    t.string "product_asset_account_id"
    t.decimal "depreciation", precision: 12, scale: 3
    t.string "purchase_description"
    t.decimal "purchase_price", precision: 12, scale: 3
    t.integer "per_carton"
    t.decimal "hotel_price", precision: 12, scale: 3
    t.decimal "price_per_carton", precision: 12, scale: 3
    t.decimal "full_value", precision: 12, scale: 3
    t.decimal "vendor_price", precision: 12, scale: 3
    t.decimal "total_cost", precision: 12, scale: 3
    t.integer "hotel_id"
    t.string "vc_code"
    t.string "mfg_code"
    t.integer "category_id"
    t.string "vendor_code"
    t.index ["style_attribute_id"], name: "index_products_on_style_attribute_id"
    t.index ["vendor_id"], name: "index_products_on_vendor_id"
  end

  create_table "style_attributes", force: :cascade do |t|
    t.integer "product_id"
    t.string "name"
    t.string "value"
    t.string "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "height"
    t.decimal "width"
    t.string "finish"
    t.index ["product_id"], name: "index_style_attributes_on_product_id"
  end

  create_table "time_log_offices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_log_works", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_requests", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "is_approve", default: false
    t.string "remarks"
    t.integer "request_type"
    t.integer "user_time_log_id"
    t.datetime "date"
    t.boolean "executed", default: false
    t.datetime "time_in"
    t.datetime "time_out"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_time_logs", force: :cascade do |t|
    t.string "description"
    t.datetime "time_in"
    t.datetime "time_out"
    t.integer "user_id"
    t.integer "duration"
    t.boolean "active", default: true
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "office_time_log_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "roles_mask"
    t.boolean "admin"
    t.integer "billing_address"
    t.integer "shipping_address"
    t.string "first_name"
    t.string "last_name"
    t.bigint "brand_id"
    t.bigint "group_id"
    t.string "mobile"
    t.text "notes"
    t.boolean "active"
    t.string "title"
    t.string "phone"
    t.integer "customer_id"
    t.integer "vendor_id"
    t.datetime "last_notified"
    t.boolean "regional_director", default: true
    t.boolean "client_contacts", default: true
    t.boolean "communications", default: true
    t.boolean "art_director", default: true
    t.boolean "designers", default: true
    t.boolean "processor", default: true
    t.string "ip_address"
    t.datetime "front_last_notified", default: "2019-04-24 14:23:47"
    t.index ["brand_id"], name: "index_users_on_brand_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_brands", force: :cascade do |t|
    t.integer "user_id"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "main_contact", default: false
  end

  create_table "users_group_details", force: :cascade do |t|
    t.integer "user_id"
    t.integer "users_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "vendor_categories", force: :cascade do |t|
    t.integer "vendor_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendor_reviews", force: :cascade do |t|
    t.text "review"
    t.integer "vendor_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lead_time"
    t.string "country_origin"
    t.bigint "product_id"
    t.string "email"
    t.integer "billing_address"
    t.decimal "balance", precision: 12, scale: 3
    t.decimal "balance_total", precision: 12, scale: 3
    t.string "bill_from_1"
    t.string "bill_from_2"
    t.string "bill_from_3"
    t.string "bill_from_4"
    t.string "bill_from_5"
    t.string "phone"
    t.string "fax"
    t.boolean "active", default: true
    t.string "company"
    t.index ["product_id"], name: "index_vendors_on_product_id"
  end

  create_table "vendors_products", force: :cascade do |t|
    t.integer "vendor_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "document_uploads", "document_uploads"
  add_foreign_key "item_messages", "order_entries"
  add_foreign_key "item_messages", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "messages", "users"
  add_foreign_key "products", "style_attributes"
  add_foreign_key "users", "addresses", column: "billing_address"
  add_foreign_key "users", "addresses", column: "shipping_address"
  add_foreign_key "users", "brands"
  add_foreign_key "users", "groups"
  add_foreign_key "vendors", "products"
end
