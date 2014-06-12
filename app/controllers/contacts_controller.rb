class ContactsController < ApplicationController

  def index
    if params[:letter].present?
      @contacts = Contact.by_letter(params[:letter])
    else
      @contacts = Contact.all
    end
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
    @contact = Contact.new
    @contact.phones.build
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to @contact
    else

      @contact.phones.build
      render action: :edit
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to :index
  end

  private

  def contact_params
    params.require(:contact).permit(:firstname, :lastname, :email, :phones_attributes => [:phone, :phone_type])
  end

end
