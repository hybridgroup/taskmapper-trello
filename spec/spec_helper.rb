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
  "7843f5d1a8776c7ee82d2581f1c5bbb1"
end

def token
  "bfa816ae1fc6966f732ad90ae924d36a65fbf8eb2798216d2ee22321a04f5c8f"
end

def username
  "andrew_stewart"
end

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


RSpec.configure do |c|
  c.before do
    stub_get(
      "https://api.trello.com/1/members/#{username}?key=#{key}&token=#{token}",
      'member.json'
    )
  end
end
