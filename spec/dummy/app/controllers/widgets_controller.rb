class WidgetsController < ApplicationController
  include ActsAsIndexable::View

  protected

    def current_attrs
      {
        id: {},
        title: { link_to: :self },
        body: {},
        actions: {
          edit: {},
          delete: {}
        }
      }
    end

end
