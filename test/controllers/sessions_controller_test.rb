require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'new_user', email: 'new_user@test.com', password: 'password1234')
  end

  test 'should get new' do
    get login_path
    assert_response :success
  end

  test 'should post create' do
    post login_path, params: { session: { email: @user.email, password: @user.password } }

    assert_redirected_to user_url(@user)
  end

  test 'should get destroy' do
    delete logout_path
    assert_redirected_to root_path
  end
end
