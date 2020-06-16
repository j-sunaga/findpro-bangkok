include Warden::Test::Helpers

module SystemHelpers
  def act_as(user)
    login user
    yield
    logout
  end

  def login(user)
    login_as user, scope: :user
    visit posts_path
    expect(page).to have_content user.email.to_s
  end

  def logout
    click_link 'Logout'
    expect(page).to have_content 'Login'
  end
end
