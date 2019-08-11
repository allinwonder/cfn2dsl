require 'spec_helper'

RSpec.describe IntrinsicFunction do
  subject { described_class.new(name, input) }

  shared_examples_for 'an intrinsic function' do
    it "creates an intrinsic function" do
      expect(subject.name).to eq(name)
      expect(subject.parameters).to eq(input)
    end
  end

  context 'Fn::Cidr()' do
    let(:name) { 'Fn::Cidr' }
    let(:input) { [ "192.168.0.0/24", 6, 5 ] }
    it_behaves_like 'an intrinsic function'
  end

  context 'Fn::Select()' do
    let(:name) { 'Fn::Select' }
    let(:input) { [0, [ "apples", "grapes", "oranges", "mangoes" ]] }

    it_behaves_like 'an intrinsic function'
  end

  context 'Fn::Sub(string)' do
    let(:name) { 'Fn::Sub' }
    let(:input) {'I am a ${single} string substitution'}
    it "creates an intrinsic function with string" do
      expect(subject.name).to eq(name)
      expect(subject.parameters).to eq(input)
      expect(subject.parameters).to be_instance_of String
    end
    it_behaves_like 'an intrinsic function'
  end

  context 'Fn::Sub(hash)' do
    let(:name) { 'Fn::Sub' }
    let(:input) { ['I am a ${hashkey} substitution', {'hashkey' => 'hashvalue'}] }
    it "creates an intrinsic function with hash" do
      expect(subject.name).to eq(name)
      expect(subject.parameters).to eq(input)
      expect(subject.parameters).to be_instance_of Array
      expect(subject.parameters[0]).to be_instance_of String
      expect(subject.parameters[1]).to be_instance_of Hash
    end
    it_behaves_like 'an intrinsic function'
  end  

  context 'Ref("AWS::Region")' do
    let(:name) { 'Ref' }
    let(:input) { 'AWS::Region' }

    it_behaves_like 'an intrinsic function'
  end
end
