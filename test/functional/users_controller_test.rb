require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @user0 = users(:user0)
  end

  test "should get show json" do
    get :show, {id: @user0.id, format: :json}
    assert_response :success
    assert_equal(@user0.email, json_response['user']['email'], "Correct email")  
  end

end
