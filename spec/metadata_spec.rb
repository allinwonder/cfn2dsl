require 'spec_helper'

RSpec.describe CloudFormation do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/Windows_Single_Server_SharePoint_Foundation.json")}
  let(:cfn_string) {cfn_file.read}

  subject { described_class.new(cfn_string) }

  it 'creates resources SharePointFoundation and it has metadata with name AWS::CloudFormation::Init' do
    r = subject.resources.find_all do |r| 
          r.name == "SharePointFoundation"
        end 
    expect(r.size).to eq 1
    expect(r.first.metadata.has_key?("AWS::CloudFormation::Init")).to be true
  end
end
