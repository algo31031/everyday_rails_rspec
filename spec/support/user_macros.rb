module UserMacros

  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in(user)
    visit root_path
    click_link "Log In"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Log In"
  end

  def fill_in_new_user_data(email)
    click_link "Users"
    click_link "New User"
    within("h1") do
      expect(page).to have_content "New User"
    end
    fill_in "user_email", with: email
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"
  end


end