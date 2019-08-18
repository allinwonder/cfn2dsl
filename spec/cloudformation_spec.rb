require 'spec_helper'

RSpec.describe CloudFormation do
  context("loads JSON files") do
    let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/samples/load-based-auto-scaling.json")}
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


  context("loads YAML files") do
    let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/samples/s3bucket.yaml")}
    let(:cfn_string) {cfn_file.read}
    let(:cfn_hash) {YAML.load(cfn_string)}

    subject { described_class.new(cfn_string) }

    it 'creates cloudformation object from cloudformation yaml' do
      expect(subject.parameters.size).to eq 5
      expect(subject.resources.size).to eq 3
      expect(subject.outputs.size).to eq 2
    end

    it 'has parameter VPCEndpoint with attribute AllowedPattern' do
      index = subject.parameters.index {|e| e.name == "VPCEndpoint"}
      expect(index).not_to be_nil
      expect(subject.parameters[index].allowed_pattern).to eq cfn_hash['Parameters']['VPCEndpoint']['AllowedPattern']
    end
  end

  context("does not load invalid YAML file") do
    let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/samples/s3bucket_invalid.yaml")}
    let(:cfn_string) {cfn_file.read}

    subject { CloudFormation }
    it 'raises a YamlSyntaxError exception' do
      allow(subject).to receive(:new).with(cfn_string).and_raise(YamlSyntaxError)
    end
  end

  context("does not load unsafe YAML file with unsupported value type") do
    let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/samples/s3bucket_unsafe.yaml")}
    let(:cfn_string) {cfn_file.read}

    subject { CloudFormation }
    it 'raises a YamlValueTypeError exception' do
      allow(subject).to receive(:new).with(cfn_string).and_raise(YamlValueTypeError)
    end
  end        

end