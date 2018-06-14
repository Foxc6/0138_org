class AddAttachmentIconImageRolloverToSkinTypes < ActiveRecord::Migration
  def self.up
    change_table :skin_types do |t|
      t.attachment :icon_image_rollover
    end
  end

  def self.down
    remove_attachment :skin_types, :icon_image_rollover
  end
end
