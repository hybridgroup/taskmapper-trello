require 'spec_helper'

module TaskMapper::Provider
  describe Trello do
    it "has a version string" do
      expect(Trello::VERSION).to be_a String
    end
  end
end
