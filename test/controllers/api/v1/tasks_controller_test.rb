require "test_helper"

class Api::V1::TasksControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    tasks = JSON.parse(response.body)["tasks"]
    first_task = tasks.first

    assert_response :success
    assert_equal 4,                            tasks.count
    assert_equal "Rock final assesment",       first_task["title"]
    assert_equal "active",                     first_task["status"]
    assert_equal "2015-05-05T09:03:51.000Z",   first_task["due_date"]
  end

  test "#show" do
    get :show, format: :json, id: Task.first.id

    task = JSON.parse(response.body)["task"]

    assert_response :success
    assert_equal "Rock final assesment",       task["title"]
    assert_equal "active",                     task["status"]
    assert_equal "2015-05-05T09:03:51.000Z",   task["due_date"]
  end

  test '#create' do
    assert_difference('Task.count', 1) do
      post :create, format: :json,
      task: { title: "Add a task", due_date: "2015-05-05T00:00:00.000Z" }
    end

    task = JSON.parse(response.body)["task"]

    assert_response :success
    assert_equal "Add a task",               task["title"]
    assert_equal "active",                   task["status"]
    assert_equal "2015-05-05T00:00:00.000Z", task["due_date"]
  end

  test '#update' do
    post :update, format: :json, id: Task.last,
    task: { title: "Add a task", due_date: "2015-05-05T00:00:00.000Z" }

    task = JSON.parse(response.body)["task"]

    assert_response :success
    assert_equal "Add a task",       task["title"]
    assert_equal "active",           task["status"]
    assert_equal "2015-05-05T00:00:00.000Z",         task["due_date"]
  end

  test '#destroy' do
    assert_difference('Task.count', -1) do
      delete :destroy, format: :json, id: Task.last
    end

    assert_response :success
  end
end
