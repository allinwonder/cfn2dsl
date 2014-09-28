require_relative 'spec_helper'

describe CloudFormation do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/load-based-auto-scaling.json")}
  let(:cfn_json) {JSON.parse(cfn_file.read)}

  subject { CloudFormation.new(cfn_json) }

  it 'creates cloudformation object from cloudformation json' do
    expect(subject.parameters.size).to eq 5
    expect(subject.resources.size).to eq 9
    expect(subject.outputs.size).to eq 1
  end

  it 'has parameter SSHLocation with attribute AllowedPattern' do
    index = subject.parameters.index {|e| e.name == "SSHLocation"}
    expect(index).not_to be_nil
    expect(subject.parameters[index].allowed_pattern).to eq cfn_json['Parameters']['SSHLocation']['AllowedPattern']
  end
end
