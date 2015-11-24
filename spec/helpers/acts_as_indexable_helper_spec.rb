require 'spec_helper'

describe ActsAsIndexable::ActsAsIndexableHelper do

  before do
    @widgets = create_list :widget, 10
  end

  it 'should provide method for rendering indexable views' do
    html = helper.render_indexable(Widget.all)
    @widgets.each do |widget|
      expect(html).to have_content(widget.to_s)
    end
  end

end
