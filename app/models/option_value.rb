class OptionValue < ActiveRecord::Base
  belongs_to :option_type, touch: true, inverse_of: :option_values
  has_many :option_values_variants
  has_and_belongs_to_many :variants, join_table: 'option_values_variants', class_name: "Variant"
  validates :name, presence: true, uniqueness: { scope: :option_type_id }
  validates :presentation, presence: true
  after_touch :touch_all_variants

  def touch_all_variants
    variants.update_all(updated_at: Time.current)
  end
end
