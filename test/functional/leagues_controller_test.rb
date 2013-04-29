require 'test_helper'

class LeaguesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

end
