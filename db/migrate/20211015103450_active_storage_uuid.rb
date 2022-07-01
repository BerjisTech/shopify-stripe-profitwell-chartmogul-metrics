# frozen_string_literal: true

# Active storage UUID
class ActiveStorageUuid < ActiveRecord::Migration[6.1]
  def up
    # action_text_rich_texts TABLES
    execute 'DROP TABLE action_text_rich_texts;'

    # active_storage_attachments TABLES
    execute 'DROP TABLE active_storage_attachments;'

    # active_storage_blobs TABLES
    execute 'DROP TABLE active_storage_blobs CASCADE;'

    # active_storage_variant_records TABLES
    execute 'DROP TABLE active_storage_variant_records;'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
