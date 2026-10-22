require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote = quotes(:one)
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

  test 'should get index' do
    get quotes_url, headers: @headers
    assert_response :success
  end

  test 'should get new' do
    get new_quote_url, headers: @headers
    assert_response :success
  end

  test 'creation without an author is rejected' do
    assert_no_difference('Quote.count') do
      post quotes_url, params: { quote: { audio: @quote.audio, body: @quote.body, date: @quote.date, source: @quote.source } }, headers: @headers, as: :json
    end
    assert_response :unprocessable_entity
    assert_includes response.parsed_body.fetch('author'), 'must exist'
  end

  test 'should show quote' do
    get quote_url(@quote), headers: @headers
    assert_response :success
  end

  test 'should get edit' do
    get edit_quote_url(@quote), headers: @headers
    assert_response :success
  end

  test 'should update quote' do
    patch quote_url(@quote), params: { quote: { body: 'Updated quote' } }, headers: @headers
    assert_redirected_to quote_url(@quote)
    assert_equal 'Updated quote', @quote.reload.body
  end

  test 'should destroy quote' do
    assert_difference('Quote.count', -1) do
      delete quote_url(@quote), headers: @headers
    end
    assert_redirected_to quotes_url
  end
end
