require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should valid user' do
    assert @user_0.valid?
  end

  test 'should invalid user without email' do
    @user_0.email = ''
    assert_not @user_0.valid?
    assert_not_empty @user_0.errors[:email]
  end

  test 'should invalid user with incorrect email' do
    @user_0.email = 'asdas'
    assert_not @user_0.valid?
    assert_not_empty @user_0.errors[:email]
  end

  test 'should invalid user without password' do
    @user_0.password = nil
    assert_not @user_0.valid?
    assert_not_empty @user_0.errors[:password]
  end

  test 'should invalid user with to short password' do
    @user_0.password = '123'
    assert_not @user_0.valid?
    assert_not_empty @user_0.errors[:password]
  end

  test 'should invalid user with wrong password confirmation' do
    @user_0.password = '1234'
    @user_0.password_confirmation = '4321'
    assert_not @user_0.valid?
    assert_not_empty @user_0.errors[:password_confirmation]
  end
end
