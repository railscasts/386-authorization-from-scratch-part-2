module AuthMacros
  def log_in(attributes = {})
    @_current_user = create(:user, attributes)
    visit login_path
    fill_in "Email", with: @_current_user.email
    fill_in "Password", with: @_current_user.password
    click_button "Log In"
    page.should have_content "Logged in"
  end

  def current_user
    @_current_user
  end
end
