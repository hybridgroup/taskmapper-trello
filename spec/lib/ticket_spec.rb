require 'spec_helper'

describe TaskMapper::Provider::Trello::Ticket do
  let(:tm) { create_instance }
  let(:ticket_class) { TaskMapper::Provider::Trello::Ticket }
  let(:project) { tm.project "4f1ef9220dc5a4633b3e9d9b" }

  describe "#tickets" do
    context "with no arguments" do
      it "returns all tickets"
    end

    context "with an array of IDs" do
      it "returns the requested tickets"
    end

    context "with a hash containing an ID" do
      it "returns the requested ticket"
    end
  end

  describe "#ticket!" do
    context "with a title and description" do
      it "creates a new ticket"
    end
  end
end
