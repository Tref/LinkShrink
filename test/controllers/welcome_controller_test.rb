require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  fixtures :links

  test "should get index" do
    get :index
    assert_response :success
    assert_select '.link-table tbody tr', 2
  end

  # testing for redirection
  test "short url should redirect to full url" do
    link = links(:one)
    get :redirect, short_url: link.short_url
    
    assert_not_nil assigns(:link)
    assert_response :redirect
  end


end