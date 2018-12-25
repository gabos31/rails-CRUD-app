require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_url
    assert_response :success
  end

  test 'should not create session with wrong data' do
    post session_url, params: { session: { email: 'aaaa@aa.aa', password: 'pp' } }
    assert_equal 'Wrong email or password!', flash[:danger]
  end

  test 'should create session' do
    auth_user_0
    assert_redirected_to root_url
  end

  test 'should delete session' do
    delete session_url
    assert_nil session[:user_id]
    assert_redirected_to root_url
  end
end
