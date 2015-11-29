class WidgetsController < ApplicationController
  include ActsAsIndexable::View

  def export
    render_exportable Widget.all
  end

  protected

    def current_attrs
      {
        id: {},
        title: { link_to: :self },
        body: {},
        created_at: { partial: 'widgets/date' },
        actions: {
          label: 'Something',
          edit: {},
          delete: {}
        }
      }
    end

end
