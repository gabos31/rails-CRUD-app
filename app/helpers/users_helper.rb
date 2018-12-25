module UsersHelper
  def auth_user?
    @user_id&. == @user.id
  end
end
