require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

end
