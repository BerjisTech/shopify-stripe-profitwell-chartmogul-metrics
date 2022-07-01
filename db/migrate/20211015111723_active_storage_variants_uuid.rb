# frozen_string_literal: true

class ActiveStorageVariantsUuid < ActiveRecord::Migration[6.1]
  def change
    create_table :active_storage_variant_records, id: :uuid do |t|
      t.belongs_to :blob, null: false, index: false, type: :uuid
      t.string :variation_digest, null: false

      t.index %i[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id, type: :uuid
    end
  end
end