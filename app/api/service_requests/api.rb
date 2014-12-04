module ServiceRequests
  class API < Grape::API

    rescue_from :all do |e|
      Rack::Response.new([ e.message ], 500, { "Content-type" => "text/error" }).finish
    end

    prefix "v1"
    format :json

    helpers do
      def current_company
        token = ApiKey.where(access_token: params[:token], active: true).first

        if token
          @current_company ||= token.company
        end
      end
    end

    resource :service_requests do

      before do
        error!('Unauthorized. Invalid token', 401) unless current_company
      end

      get do
        current_company.service_requests
      end

      params do
        optional :prefix, type: String
        requires :first_name, type: String
        requires :last_name, type: String
        requires :contact_email, type: String, regexp: User::EMAIL_REGEX
        requires :phone_number, type: String
        requires :address, type: String
        optional :address2, type: String
        requires :city, type: String
        requires :state, type: String
        requires :zip_code, type: String
        requires :country, type: String
        requires :address_type, type: String
        requires :troubleshooting_reference, type: String

        requires :line_items, type: Array do
          requires :item_type, type: String
          requires :model_number, type: String
          requires :serial_number, type: String
          optional :additional_information, type: String
        end
      end

      post do
        sr_params = params

        sr = current_company.service_requests.new(
          troubleshooting_reference: sr_params[:troubleshooting_reference],
          creation_identifier: params[:token],
          creation_source: "API"
        )

        sr_params[:line_items].each do |item|
          sr.line_items << LineItem.new(
                                          item_type: item[:item_type],
                                          model_number: item[:model_number],
                                          serial_number: item[:serial_number],
                                          additional_information: item[:additional_information] || nil
                                        )
        end

        customer = sr.create_customer(
          prefix: sr_params[:prefix],
          first_name: sr_params[:first_name],
          last_name: sr_params[:last_name],
          contact_email: sr_params[:contact_email],
          phone_number: sr_params[:phone_number]
        )

        customer.create_shipping_information(
          city: sr_params[:city],
          address: sr_params[:address],
          address2: sr_params[:address2],
          state: sr_params[:state],
          zip_code: sr_params[:zip_code],
          country: sr_params[:country],
          address_type: sr_params[:address_type]
        )

        if sr.valid? && sr.save
          sr.notify
          { success: true, service_request_id: sr.id }
        else
          sr.errors.full_messages
        end
      end
    end

    get :ping do
      { message: "I'm Alive"}
    end

  end
end
