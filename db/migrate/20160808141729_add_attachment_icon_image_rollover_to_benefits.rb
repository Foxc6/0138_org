class AddAttachmentIconImageRolloverToBenefits < ActiveRecord::Migration
  def self.up
    change_table :benefits do |t|
      t.attachment :icon_image_rollover
    end
  end

  def self.down
    remove_attachment :benefits, :icon_image_rollover
  end
end
