class ContactController < ApplicationController

  def index 
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(contact_params)
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  def new 

  end

  def create

  end

  def destroy

  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email)
  end


end
