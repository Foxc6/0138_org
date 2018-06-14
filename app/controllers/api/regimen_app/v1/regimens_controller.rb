module Api
  module RegimenApp
    module V1
      class RegimensController < Api::RegimenApp::V1::BaseController
        before_action :set_regimen, only: [:show, :edit, :update, :destroy]
        respond_to :json

        def index
          @regimens = Regimen.all
        end

        def show
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
            if @regimen.update(regimen)
              format.html { redirect_to @regimen, notice: 'Regimen was successfully updated.' }
              format.json { render :show, status: :ok, location: @regimen }
            else
              format.html { render :edit }
              format.json { render json: @regimen.errors, status: :unprocessable_entity }
            end
          end
        end

        def edit
        end

        def destroy
          @regimen.destroy
          respond_to do |format|
            format.html { redirect_to regimens_url, notice: 'Regimen was successfully destroyed.' }
            format.json { head :no_content }
          end
        end

        private

        def set_regimen
          @regimen = Regimen.find(params[:id])
        end

        def regimen_params
          params.require(:regimen).permit(
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
              :product_category_id,
              :skin_type_id,
              regimen_products_attributes: [:id, :created_at, :updated_at, :product_id, :regimen_id]
            )
        end
      end
    end
  end
end
