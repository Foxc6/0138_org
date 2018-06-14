class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  attr_accessor :master_code
  def index
    @products = Product.user_scope.paginate(:page => params[:page])

    case params['sort']
      when "name"
        @products = @products.order("name #{sort_direction}").paginate(:page => params[:page])
      when "origins_prodid"
        @products = @products.order("origins_prodid #{sort_direction}").paginate(:page => params[:page])
      when "franchise_name"
        @products = @products.order("franchise_name #{sort_direction}").paginate(:page => params[:page])
      when "collection"
        @products = @products.order("collection #{sort_direction}").paginate(:page => params[:page])
      when "product_category"
        @products = @products.order("product_category_id #{sort_direction}").paginate(:page => params[:page])
      else
        params[:direction] = 'asc'
        @products = @products.order("name #{sort_direction}").paginate(:page => params[:page])
    end
  end

  def new
    @product = Product.new
  end

  def show
  end

  def edit

  end


  def create

    @product = Product.new(product_params)
    @product.is_new = true
    respond_to do |format|
      if @product.save
      update_params = {}
      update_params["product_id"] = @product.id
      code = params["product"]["master_code"]
      upc = params["product"]["master_upc"]
      price = params["product"]["master_price"]
      size = params["product"]["master_size"]
      update_params["master"] = @product.master
      update_params["code"] = code
      update_params["upc"] = upc
      update_params["price"] = price
      update_params["size"] = size
     @product.update_variants(update_params)
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_params = {}
    update_params["product_id"] = @product.id
      code = params["product"]["master_code"]
      upc = params["product"]["master_upc"]
      price = params["product"]["master_price"]
      size = params["product"]["master_size"]
      update_params["master"] = @product.master
      update_params["code"] = code
      update_params["upc"] = upc
      update_params["price"] = price
      update_params["size"] = size
     @product.update_variants(update_params)



    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_up_options
    options_attrs.each do |name|
      option_type = OptionType.where(name: name).first_or_initialize do |option_type|
        option_type.presentation = name
        option_type.save!
      end

      unless product.option_types.include?(option_type)
        product.option_types << option_type
      end
    end
  end

  def sort_column
    ['name', 'origins_prodid', 'franchise_name', 'collection', 'product_category'].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    params[:direction] == "desc" ? params[:direction] : "asc"
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
        :franchise_name,
        :name,
        :image,
        :is_new,
        :active_ingredient,
        :description,
        :position,
        :seo_url,
        :active,
        :size,
        :code,
        :upc,
        :collection,
        :price,
        :locale_id,
        :ecomm_url,
        :product_category_id,
        :origins_prodid,
        :skin_type_ids => [],
        variants_attributes: [:id, :code, :weight, :height, :width,
          :depth, :is_master, :product_id, :price, :cost_currency,
          :position, :track_inventory, :tax_category_id,
          :stock_item_count, :upc, :_destroy,
          :option_value_ids,
          :option_values_variants_attributes => [:id, :option_value_id, :variant_id, :_destroy]
        ]
      )
  end

  def variant_params
    params.require(:variant).permit(
        :code,
        :weight,
        :height,
        :width,
        :depth,
        :is_master,
        :product_id,
        :price,
        :cost_currency,
        :position,
        :track_inventory,
        :tax_category_id,
        :stock_item_count,
        :upc,
        :option_value_ids,
        option_values_variants_attributes: [:id, :option_value_id, :variant_id, :_destroy]
      )
  end


  def option_value_params
    params.require(:option_value).permit(
      :id,
      :name,
      :option_type_id,
      :presentation
    )
  end


end
