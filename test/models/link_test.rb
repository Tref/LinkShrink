require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  fixtures :links

  setup do
    @valid_link = Link.new(full_url: "http://valid.com")
    @invalid_link = Link.new(full_url: "http://invalid")
  end

  test "link url attributes must not be empty" do
    link = Link.new
    assert link.invalid?
    assert link.errors[:full_url].any?
    assert link.errors[:short_url].any?   
  end
  
  test "link access count defaults to zero" do
    link = Link.new
    assert_equal link.access_count, 0
  end

  test "validating a link generates short_url" do
    assert @valid_link.valid?
    assert_not_empty @valid_link.short_url, "Short url is empty"
  end

  test "insensitive find or init matches mixed case" do
    link_one = links(:one)
    link_two = Link.insensitive_find_or_init({ full_url: link_one.full_url.upcase })
    assert_equal link_one, link_two
  end

  test "insensitive find or init creates new link with no match" do
    valid_link = @valid_link
    new_link = Link.insensitive_find_or_init({ full_url: valid_link.full_url })
    assert new_link.new_record?
  end

  test "validating a link downcases the full url" do
    original_link = @valid_link.dup
    @valid_link.full_url.upcase!
    assert_not_equal original_link.full_url, @valid_link.full_url
    assert @valid_link.valid?
    assert_equal  original_link.full_url, @valid_link.full_url
  end


end
