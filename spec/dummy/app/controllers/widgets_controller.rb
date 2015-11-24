class WidgetsController < ApplicationController
  include ActsAsIndexable::View

  protected

    def current_attrs
      [
        { key: :id },
        { key: :title, link_to: :self },
        { key: :body },
        { key: :created_at }
      ]
    end

end
