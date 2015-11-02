require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :links

  # A user goes to the index page. They enter a url, in the form
  # and click 'Shrink!'. After clicking the link the page should notify
  # the user that the link has been successfully created and should
  # be presented in the resulting text field with a 'Copy' button.
  # If there are less than 100 links on the page the entry should be
  # inserted in the table with the full_url, short_url (as a link) and
  # click count. If the user clicks on the short_url link they should be
  # redirected to the full_url via redirect.
  
  setup do
    @link = links(:one)
    @create = {
      full_url:       'http://newlink.com'
    }
  end

  test "creating a link and clicking it in the table" do

    get "/"

    assert_response :success
    assert_template "index"

    # send AJAX request
    xml_http_request :post, shrink_url, {link: {full_url: @link.full_url}}, {'HTTP_REFERER' => 'http://localhost:3000'}
    assert_response :success

    # 

  end
end