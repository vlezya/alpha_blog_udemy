require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: 'Sports')
    @user = User.create(username: 'Dima', email: 'test@test.com', password: 'password12', admin: true)
  end

  test 'should get index' do
    get categories_url
    assert_response :success
  end

  test 'should get new' do
    sign_in_as(@user)
    get new_category_url
    assert_response :success
  end

  test 'should create category' do
    sign_in_as(@user)
    assert_difference('Category.count', 1) do
      post categories_path, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to category_path(Category.last)
  end

  test 'should not create category if user not admin' do
    assert_no_difference('Category.count') do
      post categories_path, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to categories_path
  end

  test 'should show category' do
    get category_url(@category)
    assert_response :success
  end
end
