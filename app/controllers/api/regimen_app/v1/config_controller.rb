module Api
  module RegimenApp
    module V1
      class ConfigController < Api::RegimenApp::V1::BaseController
        respond_to :json

        def index
          regimen_data = []
          skin_type_data = []
          benefit_data = []
          benefits = Benefit.where(locale_id: @locale_data.id)
          skin_types = SkinType.where(locale_id: @locale_data.id)
          option_type_data = OptionType.where(locale_id: @locale_data.id)
          regimens = Regimen.where(locale_id: @locale_data.id).includes({products: [{variants: [:option_values]}] })

          regimens.each do |x|
            products = []

            x.products.each do |p|
              products.push({id: p.id, product_category_id: p.product_category_id})
            end
            regimen_data.push({
              id: x.id,
              name: x.name,
              benefit_id: x.benefit_id,
              skin_types: x.skin_types,
              age_range_min: x.age_range_min,
              age_range_max: x.age_range_max,
              products: products,
              categories: categories
              })
            end
          cat_data = []
          cats = categories
          child_data = {}
          cats.each do |x|
            children = []
            x.children.each do |y|
              products = []
              y.products.each do |p|
                values = p.variants.select("id", "code", "is_master", "price", "position", "upc")
                variants = []
                values.each do |value|
                  if value.option_values.any?
                    variants.push({
                      id: value.id,
                      code: value.code,
                      is_master: value.is_master,
                      price: value.price,
                      position: value.position,
                      upc: value.upc,
                      size: value.option_values.first.presentation
                    })
                  end
                end
                ms = p.master_size


                mv = Hash.new
                mv[:id] = p.master.id
                mv[:code] = p.master.code
                mv[:position] = p.master.position
                mv[:price] = p.master.price

                if ms.any?
                  size = p.master_size.first.presentation
                  mv[:size] = size
                else
                  size = nil
                end

                products.push({
                  id: p.id,
                  franchise_name: p.franchise_name,
                  name: p.name,
                  image_file_name: p.image_file_name,
                  image_url: p.image.url,
                  is_new: p.is_new,
                  active_ingredient: p.active_ingredient,
                  description: p.description,
                  collection: p.collection,
                  product_category_id: p.product_category_id,
                  skin_types: p.skin_types.select('id'),
                  master_variant: mv,
                  variants: variants
                })
              end
              cd = {
                id: y.id,
                name: y.name,
                slug: y.slug,
                is_male_only: y.is_male_only,
                position: y.position,
                products: products
              }

              children.push(cd);
            end

            child_data = {
              id: x.id,
              name: x.name,
              slug: x.slug,
              is_male_only: x.is_male_only,
              position: x.position,
              sub_categories: children
            }

            cat_data.push(child_data)
          end

          skin_types.each do |skin|
            skin_type_data.push({
              id: skin.id,
              name: skin.name,
              icon_image_file_name: skin.icon_image_file_name,
              icon_image_url: skin.icon_image.url,
              rollover_image_name: skin.icon_image_rollover_file_name,
              rollover_image_url: skin.icon_image_rollover.url
              })
          end

          benefits.each do |benefit|
            benefit_data.push({
              id: benefit.id,
              name: benefit.name,
              icon_image_file_name: benefit.icon_image_file_name,
              icon_image_url: benefit.icon_image.url,
              rollover_image_name: benefit.icon_image_rollover_file_name,
              rollover_image_url: benefit.icon_image_rollover.url
              })
          end


          @config_data = {
            "age_ranges": AgeRange.where(locale_id: @locale_data.id).select("id, name, age_min, age_max"),
            "skin_types": skin_type_data,
            "option_types": option_type_data,
            "benefits": benefit_data,
            "genders": Gender.where(locale_id: @locale_data.id).select("id, name"),
            "categories": cat_data,
            "regimens": regimen_data
          }

        end

        def categories
          @categories = ProductCategory.where(:locale_id => @locale_data.id).where(:parent_id => [nil,0]).order(:position).includes(children: [{products: [{variants: [:option_values]}] }])
        end

        def get_locales
          @locales = Locale.all.where(active: true)
        end

      end
    end
  end
end
