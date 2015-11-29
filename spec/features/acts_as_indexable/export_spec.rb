require 'spec_helper'
require 'csvlint'

describe ActsAsIndexable::View do

  context 'CSV exports' do

    before do
      @widgets = create_list(:widget, 10)
    end

    it 'should produce valid CSV' do
      validator = Csvlint::Validator.new(export_widgets_path)
      expect(validator.valid?).to be_truthy
    end

    it 'should not contain errant line-breaks' do
      visit export_widgets_path
      expect(page.body.lines.count).to eq(@widgets.count + 1)
    end

    it 'should render partials according to format' do
      visit export_widgets_path
      expect(page).to have_content(@widgets.first.created_at)
    end

  end

end
