require "test_helper"
require "json_web_token"
class ReimbursementRequestTest < ActionDispatch::IntegrationTest
  def setup
    user = personnels(:employee1)
    @token = JsonWebToken.encode(user_id: user.id)
    LoginToken.create(token: @token, personnel_id: user.id)
  end

  test "should get index" do
    get "/reimbursement", headers: { "Authorization": "Bearer #{@token}" }
    assert_response :success
  end

  test "should create new reimbursement request" do
    assert_difference('ReimbursementRequest.count') do
      post "/reimbursement",
           headers: {
             "Authorization": "Bearer #{@token}",
             "Content-Type": "application/json"
           },
           params: {
             request_amount: "432.24",
             subject: "home office chair",
             request: "Hello, I would like my office chair to be reimbursed"
           }.to_json
    end
  end

  test "should not create reimbursement request with missing params" do
    assert_no_difference('ReimbursementRequest.count') do
      post "/reimbursement",
           headers: {
             "Authorization": "Bearer #{@token}",
             "Content-Type": "application/json"
           },
           params: {
             subject: "home office chair",
             request: "Hello, I would like my office chair to be reimbursed"
           }.to_json
      assert_response :no_content
    end
  end

  test "should show reimbursement request" do
    request = reimbursement_requests(:office_chair)
    get "/reimbursement/#{request.id}", headers: { "Authorization": "Bearer #{@token}" }
    assert_response :success
  end

  test "should update reimbursement request" do
    request = reimbursement_requests(:office_chair)
    patch "/reimbursement/#{request.id}",
          headers: {
            "Authorization": "Bearer #{@token}",
            "Content-Type": "application/json"
          },
          params: {
            request_amount: "543.21"
          }.to_json
    assert_response :success
    assert_equal "543.21", request.reload.request_amount.to_s
  end

  test "should destroy reimbursement request" do
    request = reimbursement_requests(:office_chair)
    assert_difference('ReimbursementRequest.count', -1) do
      delete "/reimbursement/#{request.id}", headers: { "Authorization": "Bearer #{@token}" }
    end
    assert_response :success
  end

  test "should not destroy non-existent reimbursement request" do
    assert_no_difference('ReimbursementRequest.count') do
      delete "/reimbursement/9999", headers: { "Authorization": "Bearer #{@token}" }
    end
    assert_response :not_found
  end
end

