module ApplicationHelper
  def reset_user_id
    cookies.delete :user_id
    session.delete :user_id
    @user_id = nil
  end

  def save_cookies(id)
    cookies.encrypted[:user_id] = { value: id, expires: 1.day, httponly: true }
  end

  def floating_form_with(model: nil, scopes: nil, url: nil, **options, &block)
    opt = options.reverse_merge(builder: CustomFormBuilder, class: 'form', local: true)
    form_with model: model, scopes: scopes, url: url, **opt, &block
  end
end
