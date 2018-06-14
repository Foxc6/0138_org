# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'api_keys.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if ApiKey.exists?(row['id'])
  else
    t = ApiKey.new
    t.id = row['id']
    t.access_token = row['access_token']
    t.save!
    puts "#{t.id}, #{t.access_token} saved"
  end
end


csv_text = File.read(Rails.root.join('lib', 'seeds', 'roles.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
	if Role.exists?(row['id'])
	else
		t = Role.new
		t.id = row['id']
		t.name = row['name']
		t.save!
		puts "#{t.id}, #{t.name} saved"
	end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if User.exists?(row['id'])
  else
    t = User.new
    t.id = row['id']
    t.first_name = row['first_name']
    t.last_name = row['last_name']
    t.username = row['username']
    t.email = row['email']
    t.encrypted_password = row['encrypted_password']
    t.locale_id = row['locale_id']
    t.role_id = row['role_id']
    t.save
    puts "#{t.id}, #{t.first_name} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'locales.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
	if Locale.exists?(row['id'])
	else
		t = Locale.new
		t.id = row['id']
		t.code = row['code']
		t.fb_locale = row['fb_locale']
		t.fb_page = row['fb_page']
		t.fb_page_id = row['fb_page_id']
		t.redirect_link = row['redirect_link']
		t.logo_link = row['logo_link']
		t.active = row['active']
		t.isAPAC = row['isAPAC']
		t.tracking_code = row['tracking_code']
		t.tracking_domain = row['tracking_domain']
		t.twitter_link = row['twitter_link']
		t.name = row['name']
		t.facebook_url = row['facebook_url']
		t.twitter_url = row['twitter_url']
		t.youtube_url = row['youtube_url']
		t.pinterest_url = row['pinterest_url']
		t.instagram_url = row['instagram_url']
		t.save!
		puts "#{t.id}, #{t.code}, #{t.fb_locale}, #{t.fb_page}, #{t.fb_page_id}, #{t.redirect_link},
			 #{t.logo_link}, #{t.active}, #{t.isAPAC}, #{t.tracking_code}, #{t.tracking_domain},
			 #{t.twitter_link},#{t.name}, #{t.facebook_url}, #{t.twitter_url}, #{t.youtube_url}, #{t.pinterest_url},
			 #{t.instagram_url} saved"
	end
end


csv_text = File.read(Rails.root.join('lib', 'seeds', 'age_ranges.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if AgeRange.exists?(row['id'])
  else
    t = AgeRange.new
    t.id = row['id']
    t.name = row['name']
    t.locale_id = row['locale_id']
    t.age_min = row['age_min']
    t.age_max = row['age_max']
    t.save!
    puts "#{t.id}, #{t.name}, #{t.locale_id}, #{t.age_min}, #{t.age_max} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'genders.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if Gender.exists?(row['id'])
  else
    t = Gender.new
    t.id = row['id']
    t.name = row['name']
    t.locale_id = row['locale_id']
    t.is_male = row['is_male']
    t.save!
    puts "#{t.id}, #{t.name} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'skin_types.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if SkinType.exists?(row['id'])
  else
    t = SkinType.new
    t.id = row['id']
    t.name = row['name']
    t.locale_id = row['locale_id']
    t.icon_image_file_name = row['icon_image_file_name']
    t.icon_image_content_type = row['icon_image_content_type']
    t.icon_image_file_size = row['icon_image_file_size']
    t.icon_image_updated_at = row['icon_image_updated_at']

    t.save!
    puts "#{t.id}, #{t.name}, #{t.locale_id}, #{t.icon_image_file_name}, #{t.icon_image_content_type}, #{t.icon_image_file_size}, #{t.icon_image_updated_at} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'benefits.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if Benefit.exists?(row['id'])
  else
    t = Benefit.new
    t.id = row['id']
    t.name = row['name']
    t.locale_id = row['locale_id']
    t.icon_image_file_name = row['icon_image_file_name']
    t.icon_image_content_type = row['icon_image_content_type']
    t.icon_image_file_size = row['icon_image_file_size']
    t.icon_image_updated_at = row['icon_image_updated_at']

    t.save!
    puts "#{t.id}, #{t.name}, #{t.locale_id}, #{t.icon_image_file_name}, #{t.icon_image_content_type}, #{t.icon_image_file_size}, #{t.icon_image_updated_at} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'products.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if Product.exists?(row['id'])
  else
    t = Product.new
    t.id = row['id']
    t.product_category_id = row['product_category_id']
    t.franchise_name = row['franchise_name']
    t.name = row['name']
    t.image_file_name = row['image_file_name']
    t.image_content_type = row['image_content_type']
    t.image_file_size = row['image_file_size']
    t.image_updated_at = row['image_updated_at']
    t.is_new = row['is_new']
    t.active_ingredient = row['active_ingredient']
    t.description = row['description']
    t.position = row['position']
    t.locale_id = row['locale_id']
    t.seo_url = row['seo_url']
    t.active = row['active']
    t.collection = row['collection']
    t.origins_prodid = row['origins_prodid']

    t.save!

    #t.master.size = row['size']
    t.master.price = row['price']
    t.master.code = row['code']
    t.master.upc = row['upc']
    t.master.save!


    puts "#{t.id}, #{t.product_category_id}, #{t.franchise_name}, #{t.name}, #{t.image_file_name}, #{t.image_content_type}, #{t.image_file_size}, #{t.image_updated_at},
          #{t.is_new}, #{t.active_ingredient}, #{t.description}, #{t.position}, #{t.locale_id}, #{t.seo_url}, #{t.active},
          #{t.collection}, #{t.origins_prodid}  saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'products_skin_types.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
   product = ProductsSkinType.where(product_id: row['product_id']).where(skin_type_id: row['skin_type_id'])
  if product.any?
  else
    t = ProductsSkinType.new
    t.product_id = row['product_id']
    t.skin_type_id = row['skin_type_id']
    t.save!
    puts "Product:#{t.product_id}, SkinType:#{t.skin_type_id} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'product_categories.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if ProductCategory.exists?(row['id'])
  else
    t = ProductCategory.new
    t.id = row['id']
    t.name = row['name']
    t.slug = row['slug']
    t.position = row['position']
    t.locale_id = row['locale_id']
    t.parent_id = row['parent_id']
    t.is_male_only = row['is_male_only']

    t.save!
    puts "#{t.id}, #{t.name}, #{t.slug}, #{t.position}, #{t.locale_id}, #{t.parent_id}, #{t.is_male_only} saved"
  end
end


csv_text = File.read(Rails.root.join('lib', 'seeds', 'regimens.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if Regimen.exists?(row['id'])
  else
    t = Regimen.new
    t.id = row['id']
    t.name = row['name']
    t.age_range_id = row['age_range_id']
    t.benefit_id = row['benefit_id']
    t.gender_id = row['gender_id']
    t.locale_id = row['locale_id']
    t.age_range_min = row['age_range_min']
    t.age_range_max = row['age_range_max']

    t.save!
    puts "#{t.id}, #{t.name}, #{t.age_range_id}, #{t.benefit_id}, #{t.gender_id}, #{t.locale_id}, #{t.age_range_min}, #{t.age_range_max} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'products_regimens.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  product = ProductsRegimen.where(product_id: row['product_id']).where(regimen_id: row['regimen_id'])

  if product.any?
  else
    t = ProductsRegimen.new
    t.product_id = row['product_id']
    t.regimen_id = row['regimen_id']

    t.save!
    puts "#{t.product_id}, #{t.regimen_id} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'option_types.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if OptionType.exists?(row['id'])
  else
    t = OptionType.new
    t.id = row['id']
    t.name = row['name']
    t.presentation = row['presentation']
    t.locale_id = row['locale_id']
    t.save!
    puts "#{t.id}, #{t.name} saved"
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'option_values.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  if OptionValue.exists?(row['id'])
  else
    t = OptionValue.new
    t.id = row['id']
    t.name = row['name']
    t.option_type_id = row['option_type_id']
    t.presentation = row['presentation']
    t.save!
    puts "#{t.id}, #{t.name} saved"
  end
end

puts "Your database has been successfully seeded!"
