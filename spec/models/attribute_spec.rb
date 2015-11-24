require 'spec_helper'

describe ActsAsIndexable::Attribute do

  before do
    @col = ActsAsIndexable::Attribute.new({ key: :id })
  end

  it 'should respond_to key' do
    expect(@col.key).to eq(:id)
  end

  it 'should return label' do
    allow_any_instance_of(ActsAsIndexable::Attribute).to receive(:label).and_return('Something')
    expect(@col.label).to eq('Something')
  end

  it 'should humanize label unless defined' do
    expect(@col.label).to eq('Id')
  end

end
