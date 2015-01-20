require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  test "should get distance" do
    get :distance
    assert_response :success
  end

end
