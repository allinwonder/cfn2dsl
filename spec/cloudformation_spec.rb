require 'spec_helper'

RSpec.describe CloudFormation do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/load-based-auto-scaling.json")}
  let(:cfn_string) {cfn_file.read}
  let(:cfn_hash) {YAML.load(cfn_string)}

  subject { described_class.new(cfn_string) }

  it 'creates cloudformation object from cloudformation json' do
    expect(subject.parameters.size).to eq 5
    expect(subject.resources.size).to eq 9
    expect(subject.outputs.size).to eq 1
  end

  it 'has parameter SSHLocation with attribute AllowedPattern' do
    index = subject.parameters.index {|e| e.name == "SSHLocation"}
    expect(index).not_to be_nil
    expect(subject.parameters[index].allowed_pattern).to eq cfn_hash['Parameters']['SSHLocation']['AllowedPattern']
  end
end
