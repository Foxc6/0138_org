class RegimensController < ApplicationController
  before_action :set_regimen, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @regimens = Regimen.user_scope.paginate(:page => params[:page])

    case params['sort']
      when "name"
        @regimens = @regimens.order("name #{sort_direction}").paginate(:page => params[:page])
      when "benefit"
        @regimens = @regimens.order("benefit_id #{sort_direction}").paginate(:page => params[:page])
      when "age_min"
        @regimens = @regimens.order("age_range_min #{sort_direction}").paginate(:page => params[:page])
      when "age_max"
        @regimens = @regimens.order("age_range_max #{sort_direction}").paginate(:page => params[:page])
      else
        params[:direction] = 'asc'
        @regimens = @regimens.order("name asc").paginate(:page => params[:page])
    end
  end

  def edit
  end

  def show
    @categories = ProductCategory.user_scope.where(:parent_id => [nil,0])
  end

  def new
    @products = Product.all.user_scope
    @regimen = Regimen.new
    @categories = ProductCategory.user_scope.where(:parent_id => [nil,0])
    @children = get_children(@categories)
  end

  def get_children(categories)
    @children = []
    @categories.each do |category|
      @children.push(category)
    end
    return @children
  end

  def create
    @regimen = Regimen.new(regimen_params)
    respond_to do |format|
      if @regimen.save
        format.html { redirect_to @regimen, notice: 'Regimen was successfully created.' }
        format.json { render :show, status: :created, location: @regimen }
      else
        format.html { render :new }
        format.json { render json: @regimen.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @regimen.update(regimen_params)
        format.html { redirect_to @regimen, notice: 'Regimen was successfully updated.' }
        format.json { render :show, status: :ok, location: @regimen }
      else
        format.html { render :edit }
        format.json { render json: @regimen.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @products = Product.all.user_scope
    @categories = ProductCategory.user_scope.where(:parent_id => [nil,0])
    @children = get_children(@categories)
  end

  def destroy
    @regimen.destroy
    respond_to do |format|
      format.html { redirect_to regimens_url, notice: 'Regimen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    ['name', 'benefit', 'age_min', 'age_max'].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    params[:direction] == "desc" ? params[:direction] : "asc"
  end

  def set_regimen
    @regimen = Regimen.find(params[:id])
  end

  def regimen_params
    params.require(:regimen).permit(
        :name,
        :age_range_id,
        :benefit_id,
        :gender_id,
        :locale_id,
        :age_range_min,
        :age_range_max,
        :skin_type_ids => [],
        :product_ids => [],
      )
  end


end
