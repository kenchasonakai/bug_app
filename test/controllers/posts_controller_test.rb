require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one_post)
    @user = users(:one_user)
    login_as(@user, scope: :user)
  end

  test "should get index" do
    get posts_url
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get index with tag" do
    get posts_url, params: { tag: "example_tag" }
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get show" do
    get post_url(@post)
    assert_response :success
    assert_not_nil assigns(:post)
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { title: "New Post", content: "This is a new post." } }
    end

    assert_redirected_to posts_path
    assert_equal "投稿しました", flash[:notice]
  end

  test "should not create post with invalid data" do
    assert_no_difference("Post.count") do
      post posts_url, params: { post: { title: "", content: "" } }
    end

    assert_response :unprocessable_entity
    assert_match /投稿に失敗しました/, flash[:alert]
  end
end
