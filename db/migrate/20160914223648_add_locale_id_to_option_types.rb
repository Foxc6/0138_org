class AddLocaleIdToOptionTypes < ActiveRecord::Migration
  def change
    add_reference :option_types, :locale, index: true, foreign_key: true
  end
end
