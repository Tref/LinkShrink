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
    @existing_link = links(:one)
    @valid_link = Link.new(full_url: "http://valid.com")
    @invalid_link = Link.new(full_url: "http://invalid")
  end

  test "creating a link and clicking it in the table" do

    get "/"

    assert_response :success
    assert_template "index"

    # send AJAX request
    xml_http_request :post, shrink_url, {link: {full_url: @valid_link.full_url}}, {'HTTP_REFERER' => 'http://localhost:3000'}
    assert_response :success
    assert_template "create"

    get "/"
    assert_response :success
    assert_template "index"

    links = Link.all
    assert_equal 3, links.count


    link1 = links[0]
    link2 = links[1]
    link3 = links[2]

    assert_equal "http://apple.com", link1.full_url
    assert_equal "ff", link1.short_url
    assert_equal 0, link1.access_count
    # test table population
    assert_select '.link-table tbody tr[2] td[1]', 'http://apple.com'
    assert_select '.link-table tbody tr[2] td[3]', '0'

    assert_equal "http://google.com", link2.full_url
    assert_equal "00", link2.short_url
    assert_equal 1, link2.access_count
    # test table population
    assert_select '.link-table tbody tr[1] td[1]', 'http://google.com'
    assert_select '.link-table tbody tr[1] td[3]', '1'

    assert_equal "http://valid.com", link3.full_url
    assert_equal 0, link3.access_count
    # test table population
    assert_select '.link-table tbody tr[3] td[1]', 'http://valid.com'
    assert_select '.link-table tbody tr[3] td[3]', '0'

  end
end