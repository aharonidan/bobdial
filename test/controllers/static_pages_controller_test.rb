require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get the_rules" do
    get static_pages_the_rules_url
    assert_response :success
  end

end
