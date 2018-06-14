class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :reload_rails_admin, :if => :rails_admin_path?
  before_filter :assign_body_title
  before_filter :assign_locale

  private

  def assign_body_title
    @preference = Preference.where(default: true).first
    if @preference
      if @preference.seo_title
        @title = @preference.seo_title
        @logo = @preference.logo
      else
        @title = "default title"
      end
    else
      @title = "default title"
    end
  end

  def assign_locale
    white_list_locale
    if current_user.present?
      Rails.application.config.user_locale_id = current_user.locale_id
      @locale_name = current_user.locale.name
    end
  end

  def white_list_locale
    if(locales.include?(params[:locale]))
      @locale = params[:locale]
      I18n.locale = @locale.to_sym
    elsif params[:locale].blank?
      @locale = default_locale
      I18n.locale = @locale.to_sym
    else
      @locale = params[:locale]

      if @locale.class.is_a?(String)
        I18n.locale = @locale.to_sym
        @locale_data = Locale.where(code:@locale).first

        if @locale_data
          redirect_to  @locale_data.redirect_link
        else
          @locale = default_locale
          I18n.locale = @locale.to_sym
          @locale_data = Locale.where(code:@locale).first
          redirect_to @locale_data.redirect_link
        end
        #@locale = @locale.code
        #I18n.locale = @locale.to_sym
      else
        @locale_data = @locale
        @locale = @locale[:code]
        I18n.locale = @locale.to_sym
      end
    end
  end

  def default_locale
    case self.controller_name
    when 'main'
      @default_locale = 'en'
    else
      @default_locale = 'na'
    end
  end

  def locales
   @locales ||= Locale.where(active:true).pluck(:code)
  end

  def white_list_locale_data
    if !locale.is_a?(Locale)
      @locale_data = Locale.where(code:@locale).first
      @locale_data = Locale.where(code:'na').first unless @locale_data
    end
  end

  def reload_rails_admin
    models = %W(User UserProfile)
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset
    load("#{Rails.root}/config/initializers/rails_admin.rb")
  end

  def rails_admin_path?
    controller_path =~ /admin/ && Rails.env == "development"
  end

end
