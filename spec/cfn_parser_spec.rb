require 'spec_helper'

RSpec.describe CfnParser do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/basic-amazon-redshift-cluster.json")}
  let(:cfn_json) {JSON.parse(cfn_file.read)}

  subject { Class.new.extend described_class }

  it "parses cloudformation json" do
    cfn = subject.parse_cfn_json(cfn_json)
    expect(cfn['AWSTemplateFormatVersion']).to eq "2010-09-09"
    expect(cfn['Conditions']['IsMultiNodeCluster'].instance_of? IntrinsicFunction).to be(true)
  end
end
