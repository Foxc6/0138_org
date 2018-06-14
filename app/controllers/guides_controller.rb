require 'mandrill'
require 'digest/md5'

class GuidesController < ApplicationController
  before_action :set_guide, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @guides = Guide.user_scope.paginate(:page => params[:page])

    case params['sort']
      when "first_name"
        @guides = @guides.order("first_name #{sort_direction}").paginate(:page => params[:page])
      when "last_name"
        @guides = @guides.order("last_name #{sort_direction}").paginate(:page => params[:page])
      when "username"
        @guides = @guides.order("username #{sort_direction}").paginate(:page => params[:page])
      else
        params[:direction] = 'asc'
        @guides = @guides.order("first_name #{sort_direction}").paginate(:page => params[:page])
    end
  end

  def new
    @guide = Guide.new
  end

  def create
    @guide = Guide.new(guide_params)
    subscribe_mailchimp(@guide)
    send_guide_record(@guide)
    respond_to do |format|
      if @guide.save
        format.html { redirect_to @guide, notice: 'Guide was successfully created.' }
        format.json { render :show, status: :created, location: @guide }
      else
        format.html { render :new }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @guide.update(guide_params)
        format.html { redirect_to @guide, notice: 'Guide was successfully updated.' }
        format.json { render :show, status: :ok, location: @guide }
      else
        format.html { render :edit }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to guides_url, notice: 'Guide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def subscribe_mailchimp(guide)
    list_id = ENV['MAILCHIMP_LIST_ID']
    mailchimp = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    email = guide[:email]
    first_name = guide[:first_name]
    last_name = guide[:last_name]
    hashed_email = Digest::MD5.hexdigest(email)
    begin
      result = mailchimp.lists(list_id).members.create(
        body: {
          email_address: guide[:email],
          status: "subscribed",
          merge_fields: {
            FNAME: first_name,
            LNAME: last_name,
            EMAIL: email
            }
          })
    rescue Gibbon::MailChimpError
      result = mailchimp.lists(list_id).members(hashed_email).update(body: { status: "subscribed" })
      puts "GUIDE ALREADY CREATED::::::::::::::::::: #{result['email_address']}"
    end
  end

  def send_guide_record(guide)
    first_name = guide[:first_name]
    last_name = guide[:last_name]
    name = first_name + ' ' + last_name
    username = guide[:username]
    email = guide[:email]
    mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
    template_name = 'origin-guide'
    template_content = [{"content"=>"example content", "name"=>"example name"}]
    message = {
     "preserve_recipients"=>false,
     "view_content_link"=>true,
     "from_email"=>"notifications@illcreative.com",
     "to"=>
        [
          {"type"=>"to",
            "name"=> first_name,
            "email"=> email
          }
         ],
     "merge"=>true,
     "merge_language"=>"mailchimp",
     "global_merge_vars"=> [
        {
          "name"=>"merge1",
          "content"=>"merge1 content"
        }
     ],
     "merge_vars"=>[
        {
          "rcpt"=> email,
          "vars"=>[
            {"name"=> "firstname", "content"=> first_name},
            {"name"=> "username", "content"=> username}
          ]
        }
      ],
     "from_name"=>"Origins Natural Skin Care",
     "text"=>"Example text content",
     "auto_text"=>nil,
     "track_opens"=>nil,
     "headers"=>{"Reply-To"=>"info@illcreative.com"},
     "subject"=>"Guide Record"}
    result = mandrill.messages.send_template template_name, template_content, message

    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
    raise
  end

  private

  def sort_column
    ['first_name', 'last_name', 'username'].include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    params[:direction] == "desc" ? params[:direction] : "asc"
  end

  def set_guide
    @guide = Guide.find(params[:id])
  end

  def guide_params
    params.require(:guide).permit(
        :first_name,
        :last_name,
        :email,
        :username,
        :locale_id
      )
  end

end
