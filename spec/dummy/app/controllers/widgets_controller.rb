class WidgetsController < ApplicationController
  include ActsAsIndexable::View

  protected

    def current_attrs
      [
        { key: :id },
        { key: :title, link_to: :self },
        { key: :body },
        { key: :actions },
      ]
    end

end
