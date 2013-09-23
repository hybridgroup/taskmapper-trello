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
        check_and_replace_attribute :desc, :description
        check_and_replace_attribute :board_id, :project_id
        check_and_replace_attribute :last_activity_date, :updated_at
        set_status
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
        check_and_replace_attribute :desc, :description
        check_and_replace_attribute :board_id, :project_id
        check_and_replace_attribute :last_activity_date, :updated_at
        set_status
      end

      def update
        card = find_card
        attrs = self.to_h
        attrs['desc'] = attrs.delete('description')
        attrs['board_id'] = attrs.delete('project_id')
        card.update_fields(attrs).save
      end

      private
      def check_and_replace_attribute(base, target)
        if self[base] && !self[target]
          self[target] = self.delete(base)
        end
      end

      def set_status
        self[:status] = (self[:closed] ? 'closed' : 'open')
      end

      def find_card
        api = TaskMapper::Provider::Trello.api
        board = api.boards.find { |b| b.id == project_id }
        board.cards.find { |c| c.id == id }
      end
    end
  end
end
