# frozen_string_literal: true

class ActiveStorageActionTextUuid < ActiveRecord::Migration[6.1]
  def change
    create_table :action_text_rich_texts, id: :uuid do |t|
      t.string :name, null: false
      t.text :body, size: :long
      t.references :record, null: false, polymorphic: true, index: false, type: :uuid

      t.timestamps

      t.index %i[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
    end

    create_table :active_storage_blobs, id: :uuid do |t|
      t.string :key, null: false
      t.string :filename, null: false
      t.string :content_type
      t.text :metadata
      t.bigint :byte_size, null: false
      t.string :checksum, null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments, id: :uuid do |t|
      t.string :name, null: false
      t.references :record, null: false, polymorphic: true, index: false, type: :uuid
      t.references :blob, null: false, type: :uuid

      t.datetime :created_at, null: false

      t.index %i[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                      unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
