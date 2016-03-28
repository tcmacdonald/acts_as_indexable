module ActsAsIndexable
  module ActsAsIndexableHelper

    def render_indexable(collection, **opts)
      render partial: 'acts_as_indexable/index',
             object: collection,
             as: :collection,
             locals: { opts: opts }
    end

    def sortable(column, title=null)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, {sort: column, direction: direction}, {class: css_class}
    end
  end
end
