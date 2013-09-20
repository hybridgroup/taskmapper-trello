require 'spec_helper'

describe TaskMapper::Provider::Trello::Project do
  before do
    stub_get(
      "https://api.trello.com/1/members/4ea4f9b1ad8ba68c10013887/boards?filter=all&key=#{key}&token=#{token}",
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

  describe "#project" do
    context "with a project ID" do
      let(:project) { tm.project("4f0f2f4508f28652554231d2") }

      it "returns the requested project" do
        expect(project).to be_a project_class
        expect(project.id).to eq "4f0f2f4508f28652554231d2"
      end
    end

    context "with a hash containing a project ID" do
      let(:project) { tm.project(:id => "4f0f2f4508f28652554231d2") }

      it "returns the requested project" do
        expect(project).to be_a project_class
        expect(project.id).to eq "4f0f2f4508f28652554231d2"
      end
    end
  end

  describe "#projects" do
    context "without params" do
      let(:projects) { tm.projects }

      it "returns an array of Projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
      end
    end

    context "with an array of IDs" do
      let(:ids) { %w(4f0f2f4508f28652554231d2 4ea4fa0cd791269d4e29a176) }
      let(:projects) { tm.projects(ids) }

      it "returns an array of requested Projects" do
        expect(projects).to be_an Array
        expect(projects.first.id).to eq "4f0f2f4508f28652554231d2"
        expect(projects.last.id).to eq "4ea4fa0cd791269d4e29a176"
      end
    end

    context "with a hash" do
      let(:projects) { tm.projects(:id => "4f0f2f4508f28652554231d2") }

      it "returns the requested project in an Array" do
        expect(projects).to be_an Array
        expect(projects.length).to eq 1
        expect(projects.first.id).to eq "4f0f2f4508f28652554231d2"
      end
    end
  end
end
