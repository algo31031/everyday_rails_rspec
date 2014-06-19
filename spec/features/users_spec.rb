require "rails_helper"

feature "用户管理", type: :feature do

  let(:admin) { create :admin }

  before :each do
    sign_in(admin)
  end

  scenario "添加普通用户" do
    expect {
      fill_in_new_user_data("new_user@example.com")
      click_button "Create User"
    }.to change(User, :count).by(1)
    expect(page).to have_content "New user created."
    expect(find(:xpath, "//table//tr[last()]/td[1]")).to have_content "new_user@example.com"
    expect(find(:xpath, "//table//tr[last()]/td[2]")).to have_content "false"
  end

  scenario "添加管理员", js: true do
    expect {
      fill_in_new_user_data("new_user@example.com")
      check "user_admin"
      click_button "Create User"
      sleep 1 
    }.to change(User, :count).by(1)      
    expect(page).to have_content "New user created."
    expect(find(:xpath, "//table//tr[last()]/td[1]")).to have_content "new_user@example.com"
    expect(find(:xpath, "//table//tr[last()]/td[2]")).to have_content "true"
  end


  scenario "查看用户列表", type: :feature do
    visit users_path
    within("h1") do
      expect(page).to have_content("Users")
    end
    expect(find(:xpath, "//table//tr[1]/th[1]")).to have_content "Email"
    expect(find(:xpath, "//table//tr[1]/th[2]")).to have_content "Admin?"
  end

end