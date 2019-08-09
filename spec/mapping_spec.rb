require 'spec_helper'

RSpec.describe Mapping do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/load-based-auto-scaling.json")}
  let(:cfn_hash) {YAML.load(cfn_file.read)}
  let(:name) {"AWSInstanceType2Arch"}

  subject{ described_class.new(name, cfn_hash["Mappings"][name]) }

  it "creates mapping AWSInstanceType2Arch has key value pair m1.xlarge => Arch => 64 " do
    expect(subject.name).to eq "AWSInstanceType2Arch"
    expect(subject.values["m1.xlarge"]["Arch"]).to eq "64"
  end
end

