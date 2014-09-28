require_relative 'spec_helper'
describe CfnParser do
  include CfnParser

  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/basic-amazon-redshift-cluster.json")}
  let(:cfn_json) {JSON.parse(cfn_file.read)}

  it "parses cloudformation json" do
    cfn = parse_cfn_json(cfn_json)
    expect(cfn['AWSTemplateFormatVersion']).to eq "2010-09-09"
    expect(cfn['Conditions']['IsMultiNodeCluster'].instance_of? IntrinsicFunction).to be(true)
  end
end
