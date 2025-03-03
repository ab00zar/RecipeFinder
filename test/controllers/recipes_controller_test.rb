require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get recipe_search_url
    assert_response :success
  end

  test "should get show" do
    get recipe_show_url
    assert_response :success
  end
end
