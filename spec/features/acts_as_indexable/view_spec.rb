require 'spec_helper'

describe ActsAsIndexable::View do

  before do
    @widgets = create_list(:widget, 10)
    @attrs = {
      title: {},
      body: {},
      email: {},
      created_at: {}
    }
    allow_any_instance_of(WidgetsController).to receive(:current_attrs).and_return(@attrs)
  end

  it 'should render columns based on current attributes' do
    visit root_path
    expect(page.find('thead').text).to match('Title Body')
  end

  it 'should render labels if defined' do
    # Set key on the first attr object
    @attrs[:title][:label] = 'Name'

    visit root_path
    expect(page.find('thead').text).to match('Name Body')
  end

  it 'should link to self' do
    # Set key on the first attr object
    @attrs[:title][:link_to] = :self

    visit root_path
    expect(page).to have_link(@widgets.first.to_s)
  end

  it 'should link to email' do
    @attrs[:email][:link_to] = :email

    visit root_path
    expect(page).to have_link(@widgets.first.email, href: "mailto:#{@widgets.first.email}")
  end

  it 'should render custom partial if defined' do
    # Set key on the first attr object
    @attrs[:created_at][:partial] = 'widgets/date'

    visit root_path
    within("#widget_#{@widgets.first.id}") do
      expect(page).to have_content(@widgets.first.created_at.strftime('%B %Y'))
    end
  end

  it 'should render CSS selectors on each td if defined' do
    # Set key on the first attr object
    @attrs[:title][:class] = 'some-class-selector'

    visit root_path
    within("#widget_#{@widgets.first.id}") do
      expect(page).to have_css('td.some-class-selector')
    end
  end

  it 'should render CSV' do
    visit export_widgets_path
    expect(page).to have_content('Title,Body,Email,Created at')
    expect(page).to have_content("#{@widgets.first.title},#{@widgets.first.body}")
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

    it 'should observe label for column header' do
      @attrs[:actions][:label] = 'CTAs'
      visit root_path
      within('thead') do
        expect(page).to have_content('CTAs')
      end
    end

  end
end
