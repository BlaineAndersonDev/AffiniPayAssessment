require 'test_helper'
require "minitest/reporters"
Minitest::Reporters.use!

class CalclientControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should succeed with vaild sum call" do
    post call_path, params: { server: "sum", num1: 6, num2: 4 }
    assert_response :success
    assert_select "h2.header", "Server name: 'sum'."
  end

  test "should succeed with vaild subtract call" do
    post call_path, params: { server: "subtract", num1: 6, num2: 4 }
    assert_response :success
    assert_select "h2.header", "Server name: 'subtract'."
  end

  test "should fail gracefully with invaild server name" do
    post call_path, params: { server: "bad_server_name", num1: 6, num2: 4 }
    post call_path, params: { server: nil, num1: 6, num2: 4 }
    post call_path, params: { server: "", num1: 6, num2: 4 }
    post call_path, params: { server: "   ", num1: 6, num2: 4 }
    assert_response :success
    assert_select "h2.header", "Invalid server name."
  end

  test "should fail gracefully with invaild num1" do
    post call_path, params: { server: "sum", num1: "a", num2: 4 }
    post call_path, params: { server: "sum", num1: "1", num2: 4 }
    post call_path, params: { server: "sum", num1: nil, num2: 4 }
    post call_path, params: { server: "sum", num1: "", num2: 4 }
    post call_path, params: { server: "sum", num1: "    ", num2: 4 }
    assert_response :success
    assert_select "h2.header", "Num1 must be an integer."
  end

  test "should fail gracefully with invaild num2" do
    post call_path, params: { server: "sum", num1: 5, num2: "b" }
    post call_path, params: { server: "sum", num1: 5, num2: "10" }
    post call_path, params: { server: "sum", num1: 5, num2: nil }
    post call_path, params: { server: "sum", num1: 5, num2: "" }
    post call_path, params: { server: "sum", num1: 5, num2: "   " }
    assert_response :success
    assert_select "h2.header", "Num2 must be an integer."
  end

end
