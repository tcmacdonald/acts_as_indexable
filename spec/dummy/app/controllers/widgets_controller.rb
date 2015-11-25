class WidgetsController < ApplicationController
  include ActsAsIndexable::View

  protected

    def current_attrs
      {
        id: {},
        title: { link_to: :self },
        body: {},
        actions: {
          label: 'Something',
          edit: {},
          delete: {}
        }
      }
    end

end
