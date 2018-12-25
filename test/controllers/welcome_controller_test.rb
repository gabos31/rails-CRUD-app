require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get welcome_index_url
    assert_response :success
  end

  test 'should get 404' do
    assert_raise ActionController::RoutingError do
      get '/something/you/want/to/404'
    end
  end
end
