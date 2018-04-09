require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get group_stage" do
    get games_group_stage_url
    assert_response :success
  end

  test "should get round_of_16" do
    get games_round_of_16_url
    assert_response :success
  end

  test "should get quarter_finals" do
    get games_quarter_finals_url
    assert_response :success
  end

  test "should get semi_finals" do
    get games_semi_finals_url
    assert_response :success
  end

  test "should get final" do
    get games_final_url
    assert_response :success
  end

end
