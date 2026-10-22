module HttpAuthConcern
    extend ActiveSupport::Concern

    included do
        before_action :http_authenticate, except: :random
    end

    def http_authenticate
        expected_username = ENV["HTTP_AUTH_USERNAME"]
        expected_password = ENV["HTTP_AUTH_PASSWORD"]

        authenticate_or_request_with_http_basic do |username, password|
            expected_username.present? && expected_password.present? &&
                username == expected_username && password == expected_password
        end
    end
end
