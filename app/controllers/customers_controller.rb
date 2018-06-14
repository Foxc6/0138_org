class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @customers = Customer.user_scope.paginate(:page => params[:page])

    case params['sort']
      when "first_name"
        @customers = @customers.order("first_name #{sort_direction}").paginate(:page => params[:page])
      when "last_name"
        @customers = @customers.order("last_name #{sort_direction}").paginate(:page => params[:page])
      when "email"
        @customers = @customers.order("email #{sort_direction}").paginate(:page => params[:page])
      when "newsletter_optin"
        @customers = @customers.order("newsletter_optin #{sort_direction}").paginate(:page => params[:page])
      when "email_optin"
        @customers = @customers.order("email_optin #{sort_direction}").paginate(:page => params[:page])
      else
        params[:direction] = 'asc'
        @customers = @customers.order("first_name #{sort_direction}").paginate(:page => params[:page])
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    ['first_name', 'last_name', 'email', 'newsletter_optin', 'email_optin'].include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    params[:direction] == "desc" ? params[:direction] : "asc"
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :email,
      :newsletter_optin,
      :email_optin,
      :locale_id
      )
  end


end
