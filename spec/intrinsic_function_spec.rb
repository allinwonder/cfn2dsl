require 'spec_helper'

RSpec.describe IntrinsicFunction do
  subject { described_class.new(name, input) }

  shared_examples_for 'an intrinsic function' do
    it "creates an intrinsic function" do
      expect(subject.name).to eq(name)
      expect(subject.parameters).to eq(input)
    end
  end

  context 'Fn::Select()' do
    let(:name) { 'Fn::Select' }
    let(:input) { [0, [ "apples", "grapes", "oranges", "mangoes" ]] }

    it_behaves_like 'an intrinsic function'
  end

  context 'Ref("AWS::Region")' do
    let(:name) { 'Ref' }
    let(:input) { 'AWS::Region' }

    it_behaves_like 'an intrinsic function'
  end
end
