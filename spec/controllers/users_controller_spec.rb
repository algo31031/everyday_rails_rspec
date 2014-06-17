require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  shared_examples "能访问所有登录用户都可以访问的actions" do 

    describe "GET # index" do

      it "将全部用户赋值给@users" do
        user1 = create :user
        user2 = create :user
        get :index
        expect(assigns(:users)).to eq [@user, user1, user2].compact
      end

      it "渲染index模板" do 
        get :index
        expect(response).to render_template :index
      end

    end

  end

  describe "访客访问" do

    describe "GET # new 拒绝访问" do
      it "需要登录" do 
        get :new
        expect(response).to redirect_to login_path
      end
    end

    describe "POST # create 拒绝访问" do
      it "需要登录" do 
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to login_path
      end
    end    

    describe "GET # index 拒绝访问" do
      it "需要登录" do 
        get :index
        expect(response).to redirect_to login_path
      end
    end

  end

  describe "普通用户访问" do

    before :each do
      set_user_session(@user = create(:user))
    end

    it_behaves_like "能访问所有登录用户都可以访问的actions"

    describe "GET # new 拒绝访问" do
      it "需要管理员登录" do 
        get :new
        expect(response).to redirect_to root_url
      end
    end

    describe "POST # create 拒绝访问" do
      it "需要管理员登录" do 
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_url
      end
    end        

  end

  describe "管理员访问" do

    before :each do
      set_user_session(@user = create(:admin))
    end    

    it_behaves_like "能访问所有登录用户都可以访问的actions"

    describe "GET # new" do
      it "创建一个新User的实例赋值给@user" do 
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it "渲染new模板" do 
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST # create" do
      it "将user加入数据库" do 
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "跳转到index页面" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end 
  end

end