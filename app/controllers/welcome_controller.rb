class WelcomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @customer_regimens = CustomerRegimen.user_scope().all()
    @dashboard_data = Hash.new
    @dashboard_data[:age_ranges] = Hash.new
    @dashboard_data[:benefits] = Hash.new
    @dashboard_data[:skin_types] = Hash.new
    @dashboard_data[:guides] = Hash.new
    @age_range = AgeRange.user_scope()
    @benefit = Benefit.user_scope()
    @skin_type = SkinType.user_scope()
    @guide = Guide.user_scope()
    @age_ranges = @age_range.all

    @age_range.each do |age_range|
      cnt = CustomerRegimen.user_scope().where(age_range_id: age_range.id).count
      @dashboard_data[:age_ranges][age_range.name] = cnt
    end

    @benefit.each do |benefit|
      cnt = CustomerRegimen.user_scope().where(benefit_id: benefit.id).count
      @dashboard_data[:benefits][benefit.name] = cnt
    end

    @skin_type.each do |skin_type|
      cnt = CustomerRegimen.user_scope().where(skin_type_id: skin_type.id).count
      @dashboard_data[:skin_types][skin_type.name] = cnt
    end

    @guide.each do |guide|
      cnt = CustomerRegimen.user_scope().where(guide_id: guide.id).count
      @dashboard_data[:guides][guide.username] = cnt
    end

    @dashboard_data[:total_regimens] = @customer_regimens.length

  end

  def help
  end

  def account
  end

  def settings
    @preference = Preference.where(default: true).first
  end

end
