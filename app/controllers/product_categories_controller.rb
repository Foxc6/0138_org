class ProductCategoriesController < ApplicationController
   before_action :set_product_category, only: [:show, :edit, :update, :destroy]
   helper_method :sort_column, :sort_direction

  def index
    @product_categories = ProductCategory.user_scope.paginate(:page => params[:page])

    case params['sort']
      when "name"
        @product_categories = @product_categories.order("name #{sort_direction}").paginate(:page => params[:page])
      when "slug"
        @product_categories = @product_categories.order("slug #{sort_direction}").paginate(:page => params[:page])
      when "parent_category"
        @product_categories = @product_categories.order("parent_id #{sort_direction}").paginate(:page => params[:page])
      else
        params[:direction] = 'asc'
        @product_categories = @product_categories.order("name asc").paginate(:page => params[:page])
    end
  end

  def new
    @parent_categories = ProductCategory.where("parent_id IS ?", nil).user_scope.order(:name)
    @product_category = ProductCategory.new
  end

  def show
  end

  def edit
    @parent_categories = ProductCategory.where("parent_id IS ?", nil).user_scope.order(:name)
  end


  def create
    @product_category = ProductCategory.new(product_category_params)
    respond_to do |format|
      if @product_category.save
        format.html { redirect_to product_categories_path, notice: 'Product Category was successfully created.' }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to product_categories_path, notice: 'Product Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_category.destroy
    respond_to do |format|
      format.html { redirect_to product_categories_url, notice: 'Product Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    ['name', 'slug', 'parent_category'].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    params[:direction] == "asc" ? params[:direction] : "desc"
  end

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def product_category_params
    params.require(:product_category).permit(
        :name,
        :slug,
        :position,
        :locale_id,
        :parent_id,
        :is_male_only
      )
  end


end
