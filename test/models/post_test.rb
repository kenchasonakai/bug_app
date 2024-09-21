require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password", nickname: "testuser")
    @post = @user.posts.build(title: "Valid Title", content: "Valid content")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = "   "
    assert_not @post.valid?
  end

  test "title should not be too long" do
    @post.title = "a" * 51
    assert_not @post.valid?
  end

  test "content should not be too long" do
    @post.content = "a" * 60001
    assert_not @post.valid?
  end

  test "should belong to a user" do
    @post.user = nil
    assert_not @post.valid?
  end
end
