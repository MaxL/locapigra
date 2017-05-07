require 'test_helper'

class FilesControllerTest < ActionController::TestCase
  test "should get check_token" do
    get :check_token
    assert_response :success
  end

  test "should get download" do
    get :download
    assert_response :success
  end

end
