require 'spec_helper'

describe TaskMapper::Provider::Trello do
  let(:tm) { create_instance }

  describe "#new" do
    context "with correct params" do
      it "creates a new TaskMapper instance" do
        expect(tm).to be_a TaskMapper
      end

      it "can be called explicitly as a provider" do
        tm = TaskMapper::Provider::Trello.new(
          :developer_public_key => key,
          :member_token => token,
          :username => username
        )
        expect(tm).to be_a TaskMapper
      end
    end

    context "with missing params" do
      it "raises an error" do
        expect {
          TaskMapper.new(:trello, :developer_public_key => key)
        }.to raise_error(TaskMapper::Exception)
      end
    end

    context "without a username" do
      it "raises an error" do
        expect {
          TaskMapper.new(
            :trello,
            :developer_public_key => key,
            :member_token => token
          )
        }.to raise_error(TaskMapper::Exception)
      end
    end
  end
end
