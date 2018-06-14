class AlterVariantsUpc < ActiveRecord::Migration
  def self.up
  	change_table :variants do |t|
  		t.change :upc, :string
  	end
  end
  def self.down
  	change_table :variants do |t|
  		t.change :upc, :integer
  	end
  end
end