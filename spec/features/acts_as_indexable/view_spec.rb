require 'spec_helper'

describe ActsAsIndexable::View do

  before do
    @widgets = create_list(:widget, 10)
    @attrs = {
      title: {},
      body: {}
    }
    allow_any_instance_of(WidgetsController).to receive(:current_attrs).and_return(@attrs)
  end

  it 'should render columns based on current attributes' do
    visit root_path
    expect(page.find('thead').text).to match('Title Body')
  end

  it 'should render labels if defined' do
    # Set label key on the first attr object
    @attrs[:title][:label] = 'Name'

    visit root_path
    expect(page.find('thead').text).to match('Name Body')
  end

  it 'should link to self' do
    # Set label key on the first attr object
    @attrs[:title][:link_to] = :self

    visit root_path
    expect(page).to have_link(@widgets.first.to_s)
  end

end
