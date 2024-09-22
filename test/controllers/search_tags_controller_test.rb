require "test_helper"

class SearchTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one_user)
    login_as(user, scope: :user)
  end

  test "should get index" do
    get search_tags_url, params: { q: "example" }
    assert_response :success
  end

  test "should return matching tags" do
    ActsAsTaggableOn::Tag.create(name: "example_tag")
    ActsAsTaggableOn::Tag.create(name: "another_tag")

    get search_tags_url, params: { q: "example" }
    assert_response :success
    tags = JSON.parse(@response.body)
    assert_includes tags.map { |tag| tag }, "example_tag"
    assert_not_includes tags.map { |tag| tag }, "another_tag"
  end

  test "should limit results to 5 tags" do
    6.times { |i| ActsAsTaggableOn::Tag.create(name: "tag_#{i}") }

    get search_tags_url, params: { q: "tag" }
    assert_response :success
    tags = JSON.parse(@response.body)
    assert_equal 5, tags.length
  end
end
