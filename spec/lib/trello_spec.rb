require 'spec_helper'

describe TaskMapper::Provider::Trello do
  let(:key) { "key" }
  let(:token) { "token" }
  let(:tm) do
    TaskMapper.new(
      :trello,
      :developer_public_key => key,
      :member_token => token
    )
  end

  describe "#new" do
    context "with correct params" do
      it "creates a new TaskMapper instance" do
        expect(tm).to be_a TaskMapper
      end

      it "can be called explicitly as a provider" do
        tm = TaskMapper::Provider::Trello.new(
          :developer_public_key => key,
          :member_token => token
        )
        expect(tm).to be_a TaskMapper
      end
    end

    context "with missing params" do
      it "raises an error" do
        exception = "Please provide a developer_public_key and member_token."

        expect {
          TaskMapper.new(:trello, :developer_public_key => key)
        }.to raise_error(TaskMapper::Exception, exception)
      end
    end
  end
end
