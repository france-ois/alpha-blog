require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  test "get signing up form and create user" do
    get "/signup"
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "clo", email: "clothildes@gmail.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Listing all articles", response.body
  end

  test "get signing up form and reject invalid user submission" do
    get "/signup"
    assert_response :success
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "clo", email: " ", password: "password" } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
