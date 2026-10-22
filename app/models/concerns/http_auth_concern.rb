module HttpAuthConcern
    extend ActiveSupport::Concern

    included do
        before_action :http_authenticate, except: :random
    end

    def http_authenticate
        authenticate_or_request_with_http_basic do |username, password|
            username == ENV["HTTP_AUTH_USERNAME"] && password == ENV["HTTP_AUTH_PASSWORD"]
        end
    end
end
