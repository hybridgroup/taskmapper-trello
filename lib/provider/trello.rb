module TaskMapper::Provider
  module Trello
    include TaskMapper::Provider::Base

    class << self
      attr_accessor :developer_public_key, :member_token
    end

    def self.new(auth = {})
      TaskMapper.new(:trello, auth)
    end

    def provider
      TaskMapper::Provider::Trello
    end

    def configure(auth)
      ::Trello.configure do |c|
        c.developer_public_key = auth[:developer_public_key]
        c.member_token = auth[:member_token]
      end
    end

    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      unless auth[:developer_public_key] && auth[:member_token]
        exception = "Please provide a developer_public_key and member_token."
        raise TaskMapper::Exception.new(exception)
      end

      provider.developer_public_key = auth[:developer_public_key]
      provider.member_token = auth[:member_token]
      configure auth
    end

    def valid?
    end
  end
end
