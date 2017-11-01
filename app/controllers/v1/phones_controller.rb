module V1
  class PhonesController < ApplicationController

    before_action :set_contact
    before_action :set_phone, only: %i[update destroy]

    # GET contacts/1/phones
    def show
      render json: @contact.phones
    end

    # POST contacts/1/phone
    def create
      @contact.phones << Phone.new(phone_params)

      if @contact.save
        render json: @contact.phones,
               status: :created,
               location: contact_phones_url(@contact)
      else
        render json: @contact.errors,
               status: :unprocessable_entity
      end
    end

    # PATCH contacts/1/phone
    def update
      if @phone.update(phone_params)
        render json: @contact.phones
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE contacts/1/phone
    def destroy
      @phone.destroy
    end

    private

    def phone_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:contact_id])
    end

    def set_phone
      @phone = Phone.find(phone_params[:id])
    end
  end
end
