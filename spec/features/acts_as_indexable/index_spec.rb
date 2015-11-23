require 'spec_helper'

describe ActsAsIndexable::Index do

  before do
    create_list(:widget, 10)
  end

  it 'should render columns based on current_attrs' do
    attrs = [
      { key: :title },
      { key: :body }
    ]

    allow_any_instance_of(WidgetsController).to receive(:current_attrs).and_return(attrs)
    visit root_path
    expect(page.find('thead').text).to match('Title Body')
  end

  it 'should render labels if defined' do
    attrs = [
      { key: :title, label: 'Name' },
      { key: :body }
    ]

    allow_any_instance_of(WidgetsController).to receive(:current_attrs).and_return(attrs)
    visit root_path
    expect(page.find('thead').text).to match('Name Body')
  end

end
