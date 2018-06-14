class VariantsController < ApplicationController
  before_action :set_variant, only: [:show, :edit, :update, :destroy]


  def index
    @product = Product.find(params['product'])
    @variants = Variant.where(product_id: @product.id).where(is_master: false).paginate(:page => params[:page])
  end

  def new
    @option_types = OptionType.all
    @variant = Variant.new
    @product = Product.find(params['product'])
    # @options = OptionValue.joins(:option_values_variants).where(option_values_variants: { variant_id: @product.variant_ids }).group_by(&:option_type)
  end

  def edit
    @option_types = OptionType.all
    @product = Product.find(params['product'])
    # @options = OptionValue.joins(:option_values_variants).where(option_values_variants: { variant_id: @product.variant_ids }).group_by(&:option_type)
  end

  def show

  end

  def create

    @product = Product.find(variant_params['product_id'])
    @variant = Variant.new(variant_params)
    name = OptionType.find(@variant.option_values.first.option_type_id).name
    value = @variant.option_values.first.name
    @variant.options=[{'name'=>name, 'value' => value}]
    respond_to do |format|
      if @variant.save
        format.html { redirect_to variants_path(:product => @product.id), notice: 'Variant was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(variant_params['product_id'])
    respond_to do |format|
      if @variant.update(variant_params)
        format.html { redirect_to variants_path(:product => @product), notice: 'Variant was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @variant = Variant.find(params[:id])
    @product = @variant.product
    @variant.destroy
    respond_to do |format|
      format.html { redirect_to product_path(@product), notice: 'Variant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_variant
    @variant = Variant.find(params[:id])
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
