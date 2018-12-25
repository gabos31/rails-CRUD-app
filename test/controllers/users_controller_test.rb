require 'test_helper'
include Faker

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    password = Internet.password(4, 8)
    @user = {
      email: Internet.email,
      password: password,
      password_confirmation: password,
      first_name: Name.first_name,
      last_name: Name.last_name
    }
    @user_0_id = User.first.id
  end

  test 'should get new' do
    get new_user_path
    assert_response :success
  end

  test 'should not create user with wrong data' do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'dasd', password: '123' } }
    end
  end

  test 'should create user' do
    assert_difference('User.count', 1) do
      post users_url, params: { user: @user }
    end
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get show' do
    get user_path(@user_0_id)
    assert_response :success
  end

  test 'should redirected with wrong user id' do
    get user_path(55)
    assert_redirected_to root_url
  end

  test 'should redirected without auth' do
    get edit_user_path(@user_0_id)
    assert_redirected_to new_session_url
  end

  test 'should redirected with wrong auth' do
    auth_user_1
    get edit_user_path(@user_0_id)
    assert_redirected_to new_session_url
  end

  test 'should get edit' do
    auth_user_0
    get edit_user_path(@user_0_id)
    assert_response :success
  end

  test 'should not update user without auth' do
    patch user_path(@user_0_id), params: { user: { email: 'dasd@dd.dd' } }
    assert_redirected_to new_session_url
  end

  test 'should not update user with wrong email' do
    auth_user_0
    assert_no_changes('User.find(@user_0_id).email') do
      patch user_path(@user_0_id), params: { user: { email: 'dasd' } }
    end
  end

  test 'should update user' do
    auth_user_0
    assert_changes('User.find(@user_0_id).email', to: 'good@gmx.de') do
      patch user_path(@user_0_id), params: { user: { email: 'good@gmx.de' } }
    end
  end

  test 'should get edit password' do
    auth_user_0
    get edit_password_user_path(@user_0_id)
    assert_response :success
  end

  test 'should not update password with wrong auth' do
    auth_user_1
    patch edit_password_user_path(@user_0_id), params: { user: { old_password: 'admin',
                                                                 password: 'admin1',
                                                                 password_confirmation: 'admin1' } }
    assert_redirected_to new_session_url
  end

  test 'should not update password with wrong old password' do
    auth_user_0
    assert_no_changes('User.find(@user_0_id).password_digest') do
      patch edit_password_user_path(@user_0_id), params: { user: { old_password: 'admin1',
                                                                   password: 'admin2',
                                                                   password_confirmation: 'admin2' } }
    end
  end

  test 'should not update password with short pass' do
    auth_user_0
    assert_no_changes('User.find(@user_0_id).password_digest') do
      patch edit_password_user_path(@user_0_id), params: { user: { old_password: 'admin',
                                                                   password: 'adm',
                                                                   password_confirmation: 'adm' } }
    end
  end

  test 'should not update password with wrong confirmation' do
    auth_user_0
    assert_no_changes('User.find(@user_0_id).password_digest') do
      patch edit_password_user_path(@user_0_id), params: { user: { old_password: 'admin',
                                                                   password: 'admin1',
                                                                   password_confirmation: 'admin2' } }
    end
  end

  test 'should update password' do
    auth_user_0
    assert_changes('User.find(@user_0_id).password_digest') do
      patch edit_password_user_path(@user_0_id), params: { user: { old_password: 'admin',
                                                                   password: 'admin1',
                                                                   password_confirmation: 'admin1' } }
    end
  end

  test 'should not delete user with wrong auth' do
    auth_user_1
    delete user_path(@user_0_id)
    assert_redirected_to new_session_url
  end

  test 'should delete user' do
    auth_user_0
    assert_difference('User.count', -1) do
      delete user_path(@user_0_id)
    end
  end
end
