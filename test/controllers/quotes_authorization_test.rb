require 'test_helper'

class QuotesAuthorizationTest < ActionDispatch::IntegrationTest
  setup do
    @previous_credentials = ENV.to_h.slice('HTTP_AUTH_USERNAME', 'HTTP_AUTH_PASSWORD')
    ENV['HTTP_AUTH_USERNAME'] = 'security-test-user'
    ENV['HTTP_AUTH_PASSWORD'] = 'security-test-password'

    # Legacy quote fixtures reference a nonexistent author. Repair only the
    # transactional test data so the public JSON response has a valid author.
    Quote.update_all(author_id: authors(:one).id)
    @quote = quotes(:one)
  end

  teardown do
    %w[HTTP_AUTH_USERNAME HTTP_AUTH_PASSWORD].each do |key|
      if @previous_credentials.key?(key)
        ENV[key] = @previous_credentials.fetch(key)
      else
        ENV.delete(key)
      end
    end
  end

  test 'unauthenticated creation is rejected without changing quotes' do
    assert_quotes_unchanged do
      post quotes_url, params: { quote: { body: 'Unauthorized creation' } }, as: :json
    end
    assert_response :unauthorized
  end

  test 'unauthenticated update is rejected without changing quotes' do
    assert_quotes_unchanged do
      patch quote_url(@quote), params: { quote: { body: 'Unauthorized update' } }, as: :json
    end
    assert_response :unauthorized
  end

  test 'unauthenticated deletion is rejected without changing quotes' do
    assert_quotes_unchanged do
      delete quote_url(@quote), as: :json
    end
    assert_response :unauthorized
  end

  test 'incorrect credentials cannot mutate quotes' do
    headers = { 'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials('wrong', 'wrong') }
    assert_quotes_unchanged do
      patch quote_url(@quote), params: { quote: { body: 'Unauthorized update' } }, headers: headers, as: :json
    end
    assert_response :unauthorized
  end

  test 'random quote JSON remains public' do
    get random_quotes_url, as: :json
    assert_response :success
    assert_includes Quote.pluck(:body), response.parsed_body.fetch('body')
    assert_equal authors(:one).name, response.parsed_body.fetch('author').fetch('name')
  end

  test 'root random quote JSON remains public' do
    get root_url, as: :json
    assert_response :success
    assert response.parsed_body.key?('body')
  end

  test 'valid credentials permit quote updates' do
    headers = {
      'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV.fetch('HTTP_AUTH_USERNAME'), ENV.fetch('HTTP_AUTH_PASSWORD')
      )
    }
    patch quote_url(@quote), params: { quote: { body: 'Authorized update' } }, headers: headers, as: :json
    assert_response :success
    assert_equal 'Authorized update', @quote.reload.body
  end

  private

  def assert_quotes_unchanged
    before = Quote.order(:id).map(&:attributes)
    yield
    assert_equal before, Quote.order(:id).map(&:attributes)
  end
end
