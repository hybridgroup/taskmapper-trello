require 'spec_helper'

describe TaskMapper::Provider::Trello::Ticket do
  let(:tm) { create_instance }
  let(:ticket_class) { TaskMapper::Provider::Trello::Ticket }
  let(:project) { tm.project "4ea4fa0cd791269d4e29a176" }

  describe "#tickets" do
    context "with no arguments" do
      let(:tickets) { project.tickets }
      let(:ticket) { project.tickets.first }

      it "returns all tickets" do
        expect(tickets).to be_an Array
        expect(tickets).to_not be_empty
        expect(ticket).to be_a ticket_class
      end

      it "contains the expected values" do
        expect(ticket.id).to eq "4ea4fa0cd791269d4e29a198"
        expect(ticket.name).to eq "This is a card."
        expect(ticket.description).to eq "People can vote on cards."
        expect(ticket.project_id).to eq project.id
        expect(ticket.status).to eq 'open'
        expect(ticket.updated_at).to_not be_nil
      end
    end

    context "with an array of IDs" do
      let(:ids) { %w(4ea4fa0cd791269d4e29a198 4ea4fa0dd791269d4e29a1bd) }
      let(:tickets) { project.tickets ids }

      it "returns the requested tickets" do
        expect(tickets).to be_an Array
        expect(tickets.length).to eq 2
        expect(tickets[0].id).to eq "4ea4fa0cd791269d4e29a198"
        expect(tickets[1].id).to eq "4ea4fa0dd791269d4e29a1bd"
      end
    end

    context "with a hash containing an ID" do
      let(:tickets) { project.tickets(:id => '4ea4fa0cd791269d4e29a198' ) }

      it "returns the requested ticket" do
        expect(tickets).to be_an Array
        expect(tickets.length).to eq 1
        expect(tickets.first.id).to eq "4ea4fa0cd791269d4e29a198"
      end
    end
  end

  describe "#ticket!" do
    context "with a title and description" do
      let(:ticket) do
        project.ticket!(:name => "New Ticket", :description => "Desc")
      end

      it "creates a new ticket" do
        expect(ticket).to be_a ticket_class
        expect(ticket.name).to eq "New Ticket"
        expect(ticket.desc).to eq "Desc"
        expect(ticket.description).to eq "Desc"
      end
    end
  end
end
