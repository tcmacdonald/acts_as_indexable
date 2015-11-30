require 'spec_helper'

describe ActsAsIndexable::Attribute do

  before do
    @widget = create(:widget)
    @col = ActsAsIndexable::Attribute.new(:id, {})
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
    @col = ActsAsIndexable::Attribute.new(:id, { link_to: :self })
    expect(@col.send(:href, @widget)).to eq(@widget)
  end

  it 'should return interpolated path if link_to value contains :id' do
    @col = ActsAsIndexable::Attribute.new(:id, { link_to: '/widgets/:id/edit' })
    expect(@col.send(:href, @widget)).to eq("/widgets/#{@widget.id}/edit")
  end

  it 'should return formatted date object' do
    @col = ActsAsIndexable::Attribute.new(:created_at, { format: :short })
    formatted_date = I18n.l Widget.first.created_at, format: @col.format
    expect(@col.send(:l, Widget.first)).to eq(formatted_date)
  end

  it 'should return formatted currency' do
    @col = ActsAsIndexable::Attribute.new(:price, { format: :currency })
    expect(@col.send(:l, @widget)).to eq('$12.50')
  end

end
