require 'mandrill'
require 'digest/md5'
module Api
  module RegimenApp
    module V1
      class CustomersController < Api::RegimenApp::V1::BaseController
        before_action :set_customer, only: [:edit, :show, :update]
        skip_before_filter :verify_authenticity_token

        respond_to :json

        def index
          if params[:email] && (@data = Customer.find_by(email: params[:email]))
            @status = "success"
            @message = "OK"
          else
            @status = "error"
            @message = "Customer not found."
          end
        end

        def create
          p = customer_params
          p["locale_id"] = @locale_data.id

          customer = Customer.new(p)
          if customer.valid?
            # if p['newsletter_optin'] == '1'
            #   subscribe_mailchimp(p)
            # end
            if p['email_optin'] == '1'
              send_regimen_email(p)
            end

            customer['email'] = nil

            if customer.save!
              @data = customer
              @status = "success"
              @message = "OK"
              @customer_regimens = customer.customer_regimens

            end

          else
            @data = nil
            @status = "error"
            @message = "Email not valid or already in use"
          end
        end

        def new
        end

        def edit
        end

        def show

        end

        def update
          if customer_params["newsletter_optin"] == "0"
            list_id = ENV['MAILCHIMP_LIST_ID']
            mailchimp = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
            hashed_email = Digest::MD5.hexdigest(@customer.email)
            begin
              mailchimp.lists(list_id).members(hashed_email).update(body: { status: "unsubscribed" })
            rescue Gibbon::MailChimpError
            end
          end
          @customer.update(customer_params)
          @data = @customer
          @status = "success"
          @message = "OK"
        end

        def customer_products
          respond_with (data = {status: "ok", test: "test"})
        end


        # def subscribe_mailchimp(user)
        #   list_id = ENV['MAILCHIMP_LIST_ID']
        #   mailchimp = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
        #   email = user[:email]
        #   first_name = user[:first_name]
        #   last_name = user[:last_name]
        #   hashed_email = Digest::MD5.hexdigest(email)
        #   begin
        #     result = mailchimp.lists(list_id).members.create(
        #       body: {
        #         email_address: user[:email],
        #         status: "subscribed",
        #         merge_fields: {
        #           FNAME: first_name,
        #           LNAME: last_name,
        #           EMAIL: email
        #           }
        #         })
        #   rescue Gibbon::MailChimpError
        #     result = mailchimp.lists(list_id).members(hashed_email).update(body: { status: "subscribed" })
        #     puts "USER ALREADY CREATED::::::::::::::::::: #{result['email_address']}"
        #   end
        # end

        def send_regimen_email(user)
          customer = user
          content = "<tr>" + "<td align=" + "'center' " + "valign=" + "'bottom'" + ">" +
                    "<table border=" + "'0' " + "cellpadding=" + "'0' " + "cellspacing=" +
                    "'0' " + "width=" + "'100%' " + "id=" + "'templateColumns'" + ">" +
                    "<!-- START 10px SPACER-->" + "<div class=" + "'spacer'" + ">" + "</div>" +
                    "<!-- END 10px SPACER-->" + "<tr mc:repeatable>"


          # order by postion asc
          @categories = ProductCategory.user_scope.where(:parent_id => [nil,0]).order("postion ASC")
          category_hash = {}
          regimen = customer.customer_regimens.last
          regimen.customer_regimen_products.each do |product|
            product = product.product
            parent_slug = product.product_category.parent.slug
            category_slug = product.product_category.slug
            if !category_hash[parent_slug].present?
              category_hash[parent_slug] = []
            end
            category_hash[parent_slug].push({sub_category: category_slug, product: product})
          end
          category_hash.each do |key, array|
            content = content + "<h2 class=" + "'section_header' " + ">" + key + "</h2>" +
                              "<td align=" + "'center' " + "valign=" + "'bottom' " + "class=" +
                              "'templateColumnContainer' " + "style=" + "'padding-top:20px;'" + ">" +
                              "<table border=" + "'0' " + "cellpadding=" + "'20' " + "cellspacing=" +
                              "'0' " + "width=" + "'100%'" + ">"

              array.each do |arr|
                if arr[:product].image.url
                  url = arr[:product].image.url
                else
                  url = "/images/original/missing.png"
                end

                if arr[:product].ecomm_url.present?
                  ecomm_url = arr[:product].ecomm_url
                else
                  ecomm_url = "/"
                end
                content = content + "<tr>" + "<td align=" + "'center' " + "valign=" + "'bottom' " + "class=" +
                                  "'leftColumnBtn' " + "mc:edit=" + "'left_column_text1'" + ">" +
                                  "<h4 class=" + "'box' " + ">" + arr[:sub_category] + "</h4>" + "</td>" +
                                  "</tr>" + "<tr>" + "<td class=" + "'leftColumnContent'" + ">" +
                                  "<a href=" + "'' " + "><img src=" +"'#{url}' " + "style=" + "'max-width:260px;' " +
                                  "class=" + "'columnImage' " + "mc:label=" + "'left_column_image' " + "mc:edit=" +
                                  "'left_column_image' " + "></a></td></tr><tr><td align=" + "'center' " + "valign=" +
                                  "'bottom' " + "class=" + "'leftColumnBtn' " + "mc:edit=" + "'left_column_text1' " + ">" +
                                  "<span>" + arr[:product].franchise_name + "</span>" + "<h4>" + arr[:product].name +
                                  "</h4></td></tr><tr><td align=" + "'center' " + "valign=" + "'bottom' " +
                                  "class=" + "'leftColumnBtn' " + "mc:edit=" + "'left_column_content'" + ">" +
                                  "<a href=" + "'#{ecomm_url}' " + ">Shop Now</a></td></tr></table></td></tr></table></td></tr><!-- // END CLEANSE ROW -->"
              end

          end

          email = user[:email]
          mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
          template_name = 'customer-regimen'
          template_content = [{"content"=>"example content", "name"=>"example name"}]
          message = {
           "preserve_recipients"=>false,
           "view_content_link"=>true,
           "from_email"=>ENV["FROM_EMAIL"],
           "to"=>
              [
                {"type"=>"to",
                  "email"=> email
                }
               ],
           "merge"=>true,
           "merge_language"=>"mailchimp",
           "global_merge_vars"=> [
              {
                "name"=>"content",
                "content"=> content
              }
           ],
           "from_name"=>"Origins Natural Skin Care",
           "text"=>"Example text content",
           "auto_text"=>nil,
           "track_opens"=>nil,
           "headers"=>{"Reply-To"=>ENV["INFO_EMAIL"]},
           "subject"=>"Your Regimen"}
          result = mandrill.messages.send_template template_name, template_content, message

          rescue Mandrill::Error => e
          # Mandrill errors are thrown as exceptions
          puts "A mandrill error occurred: #{e.class} - #{e.message}"
          # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
          raise
        end

        private

        def set_customer
          @customer = Customer.find(params[:id])
        end

        def customer_params
          params.require(:customer).permit(
            :id,
            :first_name,
            :last_name,
            :email,
            :newsletter_optin,
            :email_optin,
            :locale_id,
            customer_regimens_attributes: [:id, :customer_id, :guide_id, :original_regimen_id, :benefit_id, :age_range_id, :skin_type_id, customer_regimen_products_attributes: [:id, :customer_regimen_id, :product_id] ],
          )
        end

        def customer_regimen_params
          params.require(:customer_regimen).permit(
            :id,
            :guide_id,
            :original_regimen_id,
            :age_range_id,
            :benefit_id,
            :skin_type_id,
            :customer_id,
            customer_regimen_products_attributes: [:id, :customer_regimen_id, :product_id]
          )
        end

      end
    end
  end
end
