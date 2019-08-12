require 'spec_helper'

RSpec.describe CfnParser do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/samples/basic-amazon-redshift-cluster.json")}
  let(:cfn_hash) {YAML.load(cfn_file.read)}

  subject { Class.new.extend described_class }

  it "parses cloudformation hash" do
    cfn = subject.parse_cfn(cfn_hash)
    expect(cfn['AWSTemplateFormatVersion']).to eq "2010-09-09"
    expect(cfn['Conditions']['IsMultiNodeCluster'].instance_of? IntrinsicFunction).to be(true)
  end
end
