require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do

  describe "GET # index" do 

    context "传递了letter参数" do
      it "返回一个lastname以letter参数的值为开头的数组" do
        raven = create :contact, lastname: "Raven"
        bane = create :contact, lastname: "Bane"
        get :index, letter: "R"
        expect(assigns(:contacts)).to match_array([raven])
      end

      it "渲染index模板" do
        get :index, letter: "R"
        expect(response).to render_template(:index)
      end
    end

    context "没传递letter参数" do
      it "返回全部contacts赋值给@contacts" do
        raven = create :contact, lastname: "Raven"
        bane = create :contact, lastname: "Bane"
        get :index
        expect(assigns(:contacts)).to eq [raven, bane]
      end

      it "渲染index模板" do 
        get :index
        expect(response).to render_template :index
      end
    end

  end

  describe "GET # show" do
    it "将请求的contact赋值给@contact" do
      contact = create :contact
      get :show, id: contact
      expect(assigns(:contact)).to eq contact
    end

    it "渲染show模板" do
      contact = create :contact
      get :show, id: contact
      expect(response).to render_template(:show)
    end
  end

  describe "GET # new" do
    it "新建一个Contact实例赋值给@contact"
    it "渲染new模板"
  end

  describe "POST # create" do

    before :each do 
      @phones = [
        attributes_for(:phone),
        attributes_for(:phone),          
        attributes_for(:phone)          
      ]

    end


    context "对于有效数据" do
      it "将其存入数据库" do
        expect{ 
          post :create, 
                contact: attributes_for(:contact, phones_attributes: @phones)
        }.to change(Contact, :count).by(1)
      end

      it "跳转至show页面" do
        post :create, contact: attributes_for(:contact, phones_attributes: @phones)
        expect(response).to redirect_to contact_path(assigns(:contact))
      end
    end

    context "对于无效数据" do
      it "不将其存入数据库"
      it "重新渲染new模板"
    end
  end

  describe "GET # edit" do
    it "将请求的contact赋值给@contact"
    it "渲染edit模板"
  end

  describe "PATCH # update" do
    context "对于有效数据" do
      it "将更改的数据存入数据库"
      it "跳转至show页面"
    end

    context "对于无效数据" do
      it "不将更改的数据存入数据库"
      it "重新渲染edit模板"
    end
  end

  describe "DESTROY # destroy" do
    it "在数据库里删除请求的contact"
    it "跳转到index页"
  end

end
