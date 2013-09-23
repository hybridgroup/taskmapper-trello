require 'taskmapper-trello'
require 'rspec'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path "#{File.dirname(__FILE__)}/fixtures/#{filename}"
  File.new(file_path)
end

def key
  "test"
end

def token
  "test"
end

def username
  "test_user"
end

credentials_file = "#{File.dirname(__FILE__)}/credentials.rb"
require(credentials_file) if File.exists?(credentials_file)

def stub_request(method, url, filename, status=nil)
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:body => status.last}) if status
  options.merge!({:status => status}) if status
  options.merge!({:content_type => 'application/json'})

  FakeWeb.register_uri method, url, options
end

def stub_get(*args); stub_request(:get, *args) end
def stub_post(*args); stub_request(:post, *args) end
def stub_put(*args); stub_request(:put, *args) end
def stub_delete(*args); stub_request(:delete, *args) end

def create_instance
  TaskMapper.new(
    :trello,
    :developer_public_key => key,
    :member_token => token,
    :username => username
  )
end

RSpec.configure do |c|
  c.before do
    stub_get(
      "https://api.trello.com/1/members/#{username}?key=#{key}&token=#{token}",
      'member.json'
    )

    stub_get(
      "https://api.trello.com/1/members/4ea4f9b1ad8ba68c10013887/boards?filter=all&key=#{key}&token=#{token}",
      "boards.json"
    )

    stub_get(
      "https://api.trello.com/1/boards/4ea4fa0cd791269d4e29a176/cards?filter=open&key=#{key}&token=#{token}",
      "cards.json"
    )

    stub_post(
      "https://api.trello.com/1/cards?key=#{key}&token=#{token}",
      'card.json'
    )
  end
end
