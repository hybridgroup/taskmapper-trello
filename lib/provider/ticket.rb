module TaskMapper::Provider
  module Trello
    class Ticket < TaskMapper::Provider::Base::Ticket
      class << self
        def find_by_id(project_id, ticket_id)
          api = TaskMapper::Provider::Trello.api
          board = api.boards.find { |b| b.id == project_id }
          cards = board.cards.map(&:attributes)
          card = cards.find { |c| c[:id] == ticket_id }
          self.new card
        end

        def find_by_attributes(project_id, attributes = {})
          tickets = self.find_all(project_id)
          search_by_attribute(tickets, attributes)
        end

        def find_all(project_id)
          api = TaskMapper::Provider::Trello.api
          board = api.boards.find { |b| b.id == project_id }
          cards = board.cards.map(&:attributes)
          cards.collect { |c| self.new c }
        end

        def create(attributes)
          ticket = self.new(attributes)
          ticket if ticket.save
        end
      end

      def initialize(*object)
        object = object.first if object.is_a? Array
        super object
      end

      def save
        new? ? to_card : update
      end

      def new?
        list_id.nil?
      end

      def to_card
        opts = {
          :name => name,
          :list_id => project_id,
          :desc => description
        }

        card = ::Trello::Card.create(opts)

        card = card.first if card.is_a?(Array)

        self.merge!(card.attributes)
      end
    end
  end
end
