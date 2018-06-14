class Locale < ActiveRecord::Base
  has_many :users
  has_many :preferences
  has_many :product_categories
  has_many :products
  has_many :age_ranges
  has_many :befefits
  has_many :customers
  has_many :guides
  has_many :skin_types

  def self.increment code
    where(code:code).first.increment!(:submission_count)
  end

  def market_name
  	if self.code == 'na'
  		'USA'
  	else
  		'APAC'
  	end
  end
end
