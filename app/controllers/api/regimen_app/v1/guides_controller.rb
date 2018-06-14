require 'mandrill'
require 'digest/md5'

module Api
  module RegimenApp
    module V1
      class GuidesController < Api::RegimenApp::V1::BaseController
        skip_before_filter :verify_authenticity_token
        respond_to :json

          def create
            p = guide_params
            p["locale_id"] = @locale_data.id

            guide = Guide.new(p)
            if guide.valid?
              send_guide_record(p)
            end

            if guide.save!

                @data = guide
                @status = "success"
                @message = "OK"


            else
              @data = nil
              @status = "error"
              @message = "Email not valid or already in use"
            end
          end

          def update
            set_guide
              list_id = ENV['MAILCHIMP_LIST_ID']
              mailchimp = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
              hashed_email = Digest::MD5.hexdigest(@guide.email)
              begin
                mailchimp.lists(list_id).members(hashed_email).update(body: { status: "unsubscribed" })
              rescue Gibbon::MailChimpError
              end
            @guide.update(guide_params)
            @data = @guide
            @status = "success"
            @message = "OK"
          end

          def login
            guide = Guide.where(:username => params[:username]).select("id, first_name, last_name, email, username, locale_id").first
            if guide.nil?
              @status =  "error"
              @message = "Guide not found."
            else
              @status =  "success"
              @message = "OK"
              @data = guide
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
             "from_email"=>ENV["FROM_EMAIL"],
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
                  "name"=>"content",
                  "content"=> "content"
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
             "headers"=>{"Reply-To"=>ENV["INFO_EMAIL"]},
             "subject"=>"Guide Record"}
            result = mandrill.messages.send_template template_name, template_content, message

            rescue Mandrill::Error => e
            # Mandrill errors are thrown as exceptions
            puts "A mandrill error occurred: #{e.class} - #{e.message}"
            # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
            raise
          end

          private

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
    end
  end
end
