require 'spec_helper'

describe ActsAsIndexable::Attribute do

  before do
    @widget = create(:widget)
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

  it 'should return context object if link_to value equals self' do
    @col = ActsAsIndexable::Attribute.new({ key: :id, link_to: :self })
    expect(@col.href(@widget)).to eq(@widget)
  end

  it 'should return interpolated path if link_to value contains :id' do
    @col = ActsAsIndexable::Attribute.new({ key: :id, link_to: '/widgets/:id/edit' })
    expect(@col.href(@widget)).to eq("/widgets/#{@widget.id}/edit")
  end

end
