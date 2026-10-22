require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @previous_credentials = ENV.to_h.slice('HTTP_AUTH_USERNAME', 'HTTP_AUTH_PASSWORD')
    ENV['HTTP_AUTH_USERNAME'] = 'controller-test-user'
    ENV['HTTP_AUTH_PASSWORD'] = 'controller-test-password'
    @headers = { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(
      ENV.fetch('HTTP_AUTH_USERNAME'), ENV.fetch('HTTP_AUTH_PASSWORD')
    ) }
  end

  teardown do
    %w[HTTP_AUTH_USERNAME HTTP_AUTH_PASSWORD].each do |key|
      @previous_credentials.key?(key) ? ENV[key] = @previous_credentials.fetch(key) : ENV.delete(key)
    end
  end

  test 'authenticated authors index renders' do
    get authors_url, headers: @headers
    assert_response :success
  end

  test 'authors index requires authentication' do
    get authors_url
    assert_response :unauthorized
  end

  test 'author mutation routes are not exposed' do
    [[:post, '/authors'], [:patch, "/authors/#{authors(:one).id}"], [:delete, "/authors/#{authors(:one).id}"]].each do |method, path|
      assert_raises(ActionController::RoutingError) do
        Rails.application.routes.recognize_path(path, method: method)
      end
    end
  end
end
