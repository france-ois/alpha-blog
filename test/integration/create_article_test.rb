require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "frbaum", email: "frb@gmail.com", password: "password")
    sign_in_as(@user)
    @category = Category.create(name: "Sports")
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "Title test", description: "Description test", category_ids: [1] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Title test", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/articles/new"
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path, params: { article: { title: "", description: "Description test", category_ids: [1] } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
