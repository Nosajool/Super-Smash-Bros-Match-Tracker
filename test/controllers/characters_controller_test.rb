require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get a character's page" do
    get :show, id: characters(:fox)
    assert_response :success
  end
end
