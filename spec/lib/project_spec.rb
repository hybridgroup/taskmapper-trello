require 'spec_helper'

describe TaskMapper::Provider::Trello::Project do
  before do
    stub_get(
      "https://api.trello.com/1/members/4ea4f9b1ad8ba68c10013887/boards?filter=all&key=7843f5d1a8776c7ee82d2581f1c5bbb1&token=bfa816ae1fc6966f732ad90ae924d36a65fbf8eb2798216d2ee22321a04f5c8f",
      "boards.json"
    )
  end

  let(:project_class) { TaskMapper::Provider::Trello::Project }

  let(:tm) do
    TaskMapper.new(
      :trello,
      :developer_public_key => key,
      :member_token => token,
      :username => username
    )
  end

  describe "#projects" do
    context "without params" do
      let(:projects) { tm.projects }

      it "returns an array of Projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
      end
    end
  end
end
