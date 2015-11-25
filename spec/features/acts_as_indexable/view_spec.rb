require 'spec_helper'

describe ActsAsIndexable::View do

  before do
    @widgets = create_list(:widget, 10)
    @attrs = {
      title: {},
      body: {},
      created_at: {}
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

  it 'should render custom partial if defined' do
    # Set label key on the first attr object
    @attrs[:created_at][:partial] = 'date'

    visit root_path
    within("#widget_#{@widgets.first.id}") do
      expect(page).to have_content(@widgets.first.created_at.strftime('%B %Y'))
    end
  end

  context 'with an actions column' do

    before do
      @attrs[:actions] = {
        edit: {},
        delete: {}
      }
    end

    it 'should render restful links by default' do
      visit root_path
      within("#widget_#{@widgets.first.id}") do
        expect(page).to have_link('Edit', href: "/widgets/#{@widgets.first.id}/edit")
        expect(page).to have_link('Delete', href: "/widgets/#{@widgets.first.id}")
      end
    end

    it 'should observe link_to value for each action' do
      @attrs[:actions][:edit][:link_to] = '/some/path/with/some/:id/here'
      visit root_path
      within("#widget_#{@widgets.first.id}") do
        expect(page).to have_link('Edit', href: "/some/path/with/some/#{@widgets.first.id}/here")
      end
    end

    it 'should observe label value for each action' do
      @attrs[:actions][:edit][:label] = 'Testing'
      visit root_path
      within("#widget_#{@widgets.first.id}") do
        expect(page).to have_link('Testing')
      end
    end

    it 'should pass along any custom attributes for each each action' do
      @attrs[:actions][:edit][:class] = 'some-class-selector'
      @attrs[:actions][:edit][:data] = { role: 'some-role' }
      visit root_path
      within("#widget_#{@widgets.first.id}") do
        expect(page).to have_xpath("//a[@class='some-class-selector']")
        expect(page).to have_xpath("//a[@data-role='some-role']")
      end
    end

  end
end
