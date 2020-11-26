require 'test_helper'
require "minitest/reporters"
Minitest::Reporters.use!

class CalclientControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should succeed with vaild sum call" do
    post call_path, params: { server: "sum", value1: 6, value2: 4 }
    post call_path, params: { server: "SUM", value1: 6, value2: 4 }
    post call_path, params: { server: "SuM", value1: 6, value2: 4 }
    assert_response :success
    assert_select "h3.message", "Server name: 'sum'."
  end

  test "should succeed with vaild subtract call" do
    post call_path, params: { server: "subtract", value1: 6, value2: 4 }
    post call_path, params: { server: "SUBTRACT", value1: 6, value2: 4 }
    post call_path, params: { server: "SuBtRaCt", value1: 6, value2: 4 }
    assert_response :success
    assert_select "h3.message", "Server name: 'subtract'."
  end

  test "should succeed with vaild concanate_upcase call" do
    post call_path, params: { server: "concanate_upcase", value1: "Example", value2: "Text" }
    post call_path, params: { server: "CoNcAnAtE_UpCaSe", value1: "Example", value2: "Text" }
    post call_path, params: { server: "CONCANATE_UPCASE", value1: "Example", value2: "Text" }
    post call_path, params: { server: "CONCANATE_UPCASE", value1: "Example", value2: "Text" }
    assert_response :success
    assert_select "h3.message", "Server name: 'concanate_upcase'."
  end

  test "should fail gracefully with invaild server name" do
    post call_path, params: { server: "bad_server_name", value1: 6, value2: 4 }
    post call_path, params: { server: nil, value1: 6, value2: 4 }
    post call_path, params: { server: "", value1: 6, value2: 4 }
    post call_path, params: { server: "   ", value1: 6, value2: 4 }
    post call_path, params: { server: "This could be any name", value1: 6, value2: 4 }
    post call_path, params: { server: "@#!$%!@#$GTWIVBWEFRV~#$@#!~$~!@$R", value1: 6, value2: 4 }
    assert_response :success
    assert_select "h3.message", "Invalid server name."
  end

  test "should fail gracefully with invaild value1 for integer servers" do
    post call_path, params: { server: "sum", value1: "a", value2: 4 }
    post call_path, params: { server: "sum", value1: "1", value2: 4 }
    post call_path, params: { server: "sum", value1: nil, value2: 4 }
    post call_path, params: { server: "sum", value1: "", value2: 4 }
    post call_path, params: { server: "sum", value1: "    ", value2: 4 }
    assert_response :success
    assert_select "h3.message", "Value1 must be an integer."
  end

  test "should fail gracefully with invaild value2 for integer servers" do
    post call_path, params: { server: "sum", value1: 5, value2: "b" }
    post call_path, params: { server: "sum", value1: 5, value2: "10" }
    post call_path, params: { server: "sum", value1: 5, value2: nil }
    post call_path, params: { server: "sum", value1: 5, value2: "" }
    post call_path, params: { server: "sum", value1: 5, value2: "   " }
    assert_response :success
    assert_select "h3.message", "Value2 must be an integer."
  end

  test "should fail gracefully with invaild value1 for string servers" do
    post call_path, params: { server: "concanate_upcase", value1: 1, value2: "test" }
    post call_path, params: { server: "concanate_upcase", value1: 0, value2: "test" }
    post call_path, params: { server: "concanate_upcase", value1: nil, value2: "test" }
    post call_path, params: { server: "concanate_upcase", value1: "", value2: "test" }
    post call_path, params: { server: "concanate_upcase", value1: "    ", value2: "test" }
    assert_response :success
    assert_select "h3.message", "Value1 must be a string."
  end

  test "should fail gracefully with invaild value2 for string servers" do
    post call_path, params: { server: "concanate_upcase", value1: "example", value2: 1 }
    post call_path, params: { server: "concanate_upcase", value1: "example", value2: 0 }
    post call_path, params: { server: "concanate_upcase", value1: "example", value2: nil }
    post call_path, params: { server: "concanate_upcase", value1: "example", value2: "" }
    post call_path, params: { server: "concanate_upcase", value1: "example", value2: "   " }
    assert_response :success
    assert_select "h3.message", "Value2 must be a string."
  end

end
