require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "", email: "user@invalid", password: "fail", password_confirmation: "fail" } }
    end 
    assert_template 'users/new'   
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: {user: { name: "Test", email: "test@email.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
