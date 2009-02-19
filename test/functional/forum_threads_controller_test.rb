require 'test_helper'

class ForumThreadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_threads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forum_thread" do
    assert_difference('ForumThread.count') do
      post :create, :forum_thread => { }
    end

    assert_redirected_to forum_thread_path(assigns(:forum_thread))
  end

  test "should show forum_thread" do
    get :show, :id => forum_threads(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => forum_threads(:one).id
    assert_response :success
  end

  test "should update forum_thread" do
    put :update, :id => forum_threads(:one).id, :forum_thread => { }
    assert_redirected_to forum_thread_path(assigns(:forum_thread))
  end

  test "should destroy forum_thread" do
    assert_difference('ForumThread.count', -1) do
      delete :destroy, :id => forum_threads(:one).id
    end

    assert_redirected_to forum_threads_path
  end
end
