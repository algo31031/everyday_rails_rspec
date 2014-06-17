require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do

  shared_examples "可公开访问的contact actions" do 

    describe "GET # index" do
      before :each do 
        @raven = create :contact, lastname: "Raven"
        @bane = create :contact, lastname: "Bane"
      end

      context "传递了letter参数" do
        it "返回一个lastname以letter参数的值为开头的数组" do
          get :index, letter: "R"
          expect(assigns(:contacts)).to match_array([@raven])
        end

        it "渲染index模板" do
          get :index, letter: "R"
          expect(response).to render_template(:index)
        end
      end

      context "没传递letter参数" do
        it "返回全部contacts赋值给@contacts" do
          get :index
          expect(assigns(:contacts)).to eq [@bane, @raven]
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

  end

  shared_examples "需要登录过才可访问的contacts actions" do

    describe "GET # new" do
      it "新建一个Contact实例赋值给@contact" do
        get :new
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it "渲染new模板" do
        get :new
        expect(response).to render_template :new
      end
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
        it "不将其存入数据库" do
          expect {
            post :create,
                  contact: attributes_for(:invalid_contact, phones_attributes: @phones)
          }.to change(Contact, :count).by(0)
        end

        it "重新渲染new模板" do 
          post :create, contact: attributes_for(:invalid_contact, phones_attributes: @phones)
          expect(response).to render_template(:new)
        end
      end
    end

    describe "GET # edit" do
      it "将请求的contact赋值给@contact" do
        contact = create(:contact)
        get :edit, id: contact
        expect(assigns(:contact)).to eq contact
      end

      it "渲染edit模板" do
        contact = create(:contact)
        get :edit, id: contact
        expect(response).to render_template(:edit)
      end
    end

    describe "PATCH # update" do

      before :each do 
        @contact = create(:contact, firstname: "Luke", lastname: "Skywalker")
      end

      context "对于有效数据" do
        it "将请求的contact赋值给@contact" do
          patch :update, id: @contact, contact: attributes_for(:contact)
          expect(assigns :contact).to eq(@contact)
        end      

        it "将更改的数据存入数据库" do
          patch :update, id: @contact, contact: attributes_for(:contact, 
                                                                firstname: "a", 
                                                                lastname: "b", 
                                                                email: "a@b.com" )
          @contact.reload
          expect(@contact.firstname).to eq "a"
          expect(@contact.lastname).to eq "b"
          expect(@contact.email).to eq "a@b.com"
        end

        it "跳转至show页面" do
          patch :update, id: @contact, contact: attributes_for(:contact)
          expect(response).to redirect_to @contact
        end 
      end

      context "对于无效数据" do
        it "不将更改的数据存入数据库" do
          patch :update, id: @contact, contact: attributes_for(:contact,
                                                                firstname: "John",
                                                                lastname: nil)
          @contact.reload
          expect(@contact.firstname).to_not eq "John"
          expect(@contact.lastname).to eq "Skywalker"        
        end

        it "重新渲染edit模板" do
          patch :update, id: @contact, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DESTROY # destroy" do
      before :each do
        @contact = create :contact
      end

      it "在数据库里删除请求的contact" do
        expect {
          delete :destroy, id: @contact
        }.to change(Contact, :count).by(-1)
      end

      it "跳转到index页" do
        delete :destroy, id: @contact
        expect(response).to redirect_to contacts_url
      end
    end

  end

  describe "访客访问" do

    it_behaves_like "可公开访问的contact actions"

    describe "GET # new  拒绝访问" do
      it "需要登录" do
        get :new
        expect(response).to redirect_to login_url
      end
    end

    describe "POST # create  拒绝访问" do
      it "需要登录" do
        post :create, contact: attributes_for(:contact)
        expect(response).to redirect_to login_url
      end
    end    

    describe "GET # edit  拒绝访问" do
      it "需要登录" do
        get :edit, id: create(:contact)
        expect(response).to redirect_to login_url
      end
    end    

    describe "PATCH # update  拒绝访问" do
      it "需要登录" do
        patch :update, id: create(:contact), contact: attributes_for(:contact)
        expect(response).to redirect_to login_url
      end
    end

    describe "DELETE # destroy  拒绝访问" do
      it "需要登录" do
        delete :destroy, id: create(:contact)
        expect(response).to redirect_to login_url
      end
    end   

  end

  describe "普通用户访问" do

    before :each do 
      set_user_session create(:user)
    end
    
    it_behaves_like "可公开访问的contact actions"

    it_behaves_like "需要登录过才可访问的contacts actions"

  end

  describe "管理员访问" do

    before :each do 
      set_user_session create(:admin)
    end
    
    it_behaves_like "可公开访问的contact actions"

    it_behaves_like "需要登录过才可访问的contacts actions"

  end

end
