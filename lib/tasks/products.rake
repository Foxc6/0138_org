namespace :products do
  desc "ensure master variants for all products"
  task create_master_variants: :environment do

    products = Product.all
    products.each do |product|
     variant = product.variants.where(is_master: true).first
      if variant.present?
      else
        v = Variant.new
        v.is_master = true
        v.product_id = product.id
        if product.price
          v.price = product.price
        else
          v.price = 0.00
        end
        v.save!
      end
    end
  end


  desc "Add option types to products"
  task add_option_types: :environment do
    products = Product.all
    option_types = OptionType.all
    option_types.each do |option|
      products.each do |product|
        pot = ProductOptionType.new
        pot.product_id = product.id
        pot.option_type_id = option.id
        pot.save!
      end
    end
  end

end
