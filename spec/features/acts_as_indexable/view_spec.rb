require 'spec_helper'

describe ActsAsIndexable::View do

  before do
    @widgets = create_list(:widget, 10)
    @attrs = [
      { key: :title },
      { key: :body }
    ]
    allow_any_instance_of(WidgetsController).to receive(:current_attrs).and_return(@attrs)
  end

  it 'should render columns based on current attributes' do
    visit root_path
    expect(page.find('thead').text).to match('Title Body')
  end

  it 'should render labels if defined' do
    # Set label key on the first attr object
    @attrs[0][:label] = 'Name'

    visit root_path
    expect(page.find('thead').text).to match('Name Body')
  end

end
