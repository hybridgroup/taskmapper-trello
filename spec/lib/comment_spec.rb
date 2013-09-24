require 'spec_helper'

describe TaskMapper::Provider::Trello::Ticket do
  let(:tm) { create_instance }
  let(:comment_class) { TaskMapper::Provider::Trello::Comment }
  let(:project) { tm.project "4ea4fa0cd791269d4e29a176" }

  describe "#comments" do
    context "with no arguments" do
      it "returns all tickets"
    end

    context "with an array of comment IDs" do
      it "returns the requested comments"
    end

    context "with a hash containing a comment ID" do
      it "returns the requested comment"
    end
  end

  describe "#comment!" do
    it "creates a new comment"
  end
end
