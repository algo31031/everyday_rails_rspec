class PhonesController < ApplicationController

  def show
    @contact = Contact.find(params[:contact_id])
    @phone = @contact.phones.find(params[:id])
  end

end
