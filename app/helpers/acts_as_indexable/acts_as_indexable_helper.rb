module ActsAsIndexable
  module ActsAsIndexableHelper

    def render_indexable(collection, **opts)
      render partial: 'acts_as_indexable/index',
             object: collection,
             as: :collection,
             locals: { opts: opts }
    end

  end
end
