require 'rails_helper'

RSpec.describe PhonesController, :type => :controller do

  describe "GET # show" do
    before :each do 
      @contact = create :contact
      @phone = create :phone, contact: @contact
    end

    it "将请求的contact和phone分别赋值给@contact和@phone" do
      get :show, id: @phone, contact_id: @contact.id
      expect(assigns(:phone)).to eq @phone
      expect(assigns(:contact)).to eq @contact
    end

    it "渲染show模板" do
      get :show, id: @phone, contact_id: @contact.id
      expect(response).to render_template :show
    end
  end

end
