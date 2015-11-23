class WidgetsController < ApplicationController
  include ActsAsIndexable::Index

  protected

    def current_attrs
      [
        { key: :id },
        { key: :title },
        { key: :body },
        { key: :created_at }
      ]
    end

end
