module TaskMapper::Provider
  module Trello
    class Project < TaskMapper::Provider::Base::Project

      def initialize(*object)
        if object.first
          object = object.first
          super object
        end
      end

      class << self
        def find_by_attributes(attributes = {})
          search_by_attribute(self.find_all, attributes)
        end

        def find_all
          boards = TaskMapper::Provider::Trello.api.boards
          boards.map { |board| self.new board.attributes }
        end
      end
    end
  end
end
