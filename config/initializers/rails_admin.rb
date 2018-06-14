RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    if !current_user
      redirect_to '/'
    else
      unless current_user.role_id == Role.where(name:'Super Admin').first.id
        flash[:error] = "You must be an admin"
        redirect_to '/'
      end
    end
  end

  config.label_methods << :email
  config.current_user_method(&:current_user)


  config.included_models = ['AgeRange', 'ApiKey', 'Customer', 'Benefit', 'Gender', 'Guide', 'Message', 'Option', 'Preference', 'Product', 'ProductCategory', 'ProductVariant', 'Regimen', 'CustomerRegimen', 'CustomerRegimenProduct', 'User', 'SkinType']


  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration



  config.model 'AgeRange' do
    list do
      scopes [:user_scope]
      field :name
      field :age_min
      field :age_max
    end
    edit do
      field :name
      field :age_min
      field :age_max
    end
  end

  config.model 'Benefit' do
    list do
      scopes [:user_scope]
      field :name
      field :icon_image
      field :icon_image_rollover
      field :benefit_products
      field :products
    end
    edit do
      field :name
      field :icon_image do
        delete_method :delete_icon_image
      end
      field :icon_image_rollover do
        delete_method :delete_icon_image_rollover
      end
    end
  end

  config.model 'Customer' do
    list do
      scopes [:user_scope]
      field :first_name
      field :last_name
      field :email
      field :newsletter_optin
      field :email_optin
      field :customer_regimens
      field :customer_regimen_products
    end
    edit do
      field :first_name
      field :last_name
      field :email
      field :newsletter_optin
      field :email_optin
      field :customer_regimens
      field :customer_regimen_products
    end
  end

  config.model 'CustomerRegimenProduct' do
    list do
      field :customer_regimen
      field :product
    end
    edit do
      field :customer_regimen
      field :product do
        inline_add true
        associated_collection_cache_all true
        associated_collection_scope do
          customer_regimen_product = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
    end
  end

  config.model 'Gender' do
    list do
      scopes [:user_scope]
      field :name
    end
    edit do
      field :name
    end
  end

  config.model 'Guide' do
    list do
      scopes [:user_scope]
      field :first_name
      field :last_name
      field :email
      field :username
    end
    edit do
      field :first_name
      field :last_name
      field :email
      field :username
    end
  end

  config.model 'Locale' do
    visible do
      bindings[:controller].current_user.role == 'Super Admin'
    end
     list do
      field :name
      field :code
      field :active
      field :updated_at
    end
    edit do
      field :code
      field :fb_locale
      field :fb_page
      field :redirect_link
      field :logo_link
      field :active
      field :isAPAC do
        label "isAPAC"
      end
      field :tracking_code
      field :tracking_domain
      field :twitter_link
      field :name
      field :facebook_url
      field :twitter_url
      field :youtube_url
      field :pinterest_url
      field :instagram_url
      field :users do
        inline_add false
      end
    end
  end

  config.model 'Product' do
    list do
      scopes [:user_scope]
      field :franchise_name
      field :name
      field :ecomm_url
      field :image
      field :is_new
      field :active_ingredient
      field :description
      field :position
      field :seo_url
      field :active
      field :collection
      field :product_category
      field :skin_types
    end
    edit do
      field :franchise_name
      field :name
      field :ecomm_url
      field :image do
        delete_method :delete_image
      end
      field :is_new
      field :active_ingredient
      field :description
      field :position
      field :seo_url
      field :active
      field :collection
      field :skin_types do
        nested_form false
        inline_add true
        associated_collection_cache_all true
        associated_collection_scope do
          product = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
      field :product_category do
          inline_add true
          associated_collection_cache_all false
          associated_collection_scope do
            product = bindings[:object]
            Proc.new { |scope|
              scope = scope.where(parent_id: nil).user_scope
            }
          end
      end
    end
  end

  config.model 'ProductCategory' do
    list do
      scopes [:user_scope]
      field :name
      field :slug
      field :position
      field :parent
      field :is_male_only
    end
    edit do
      field :name
      field :slug
      field :position
      field :parent do
        inline_add true
        associated_collection_cache_all false
        associated_collection_scope do
          product_category = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
      field :is_male_only
    end
  end


  config.model 'Regimen' do
    list do
      scopes [:user_scope]
      field :name
      field :age_range
      field :benefit
      field :gender
      field :skin_types
      field :age_range_min
      field :age_range_max
    end
    edit do
      field :name
      field :age_range do
        inline_add true
        associated_collection_cache_all false
        associated_collection_scope do
          regimen = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
      field :benefit do
        inline_add true
        associated_collection_cache_all false
        associated_collection_scope do
          regimen = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
      field :gender do
        inline_add true
        associated_collection_cache_all false
        associated_collection_scope do
          regimen = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
      field :skin_types do
        nested_form false
        inline_add true
        associated_collection_cache_all true
        associated_collection_scope do
          product = bindings[:object]
          Proc.new { |scope|
            scope = scope.user_scope
          }
        end
      end
      field :age_range_min
      field :age_range_max
    end
  end

  config.model 'SkinType' do
    list do
      scopes [:user_scope]
      field :name
      field :icon_image
      field :icon_image_rollover
    end
    edit do
      field :name
      field :icon_image do
        delete_method :delete_icon_image
      end
      field :icon_image_rollover do
        delete_method :delete_icon_image_rollover
      end
    end
  end

  config.model 'User' do
     list do
      field :first_name
      field :last_name
      field :email
      field :locale
      field :role
    end
    edit do
      field :first_name
      field :last_name
      field :email
      field :password
      field :password_confirmation
      field :locale do
        required true
        inline_add false
        inline_edit false
      end
      field :role do
        required true
        inline_add false
        inline_edit false
      end
      field :avatar do
        help '385px x 350px JPEG or PNG FIle'
        delete_method :delete_avatar
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
