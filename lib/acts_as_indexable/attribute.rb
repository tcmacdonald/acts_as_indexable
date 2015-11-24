module ActsAsIndexable
  class Attribute
    include ActionView::Helpers::UrlHelper

    attr_accessor :key,
                  :label,
                  :path

    def initialize(key, attrs={})
      @key = key
      @label = attrs.try(:[], :label) || @key.to_s.humanize
      @path = attrs.try(:[], :link_to)
    end

    def l(ctx)
      ctx.send(@key)
    end

    def href(ctx, path=nil)
      path ||= @path
      if path.present?
        if path.to_s == 'self'
          ctx
        elsif
          path.scan(/:[a-z]*/).each do |attr|
            path.gsub!(/#{attr}/, ctx.send(attr[1..-1].to_sym).to_s)
          end
          path
        end
      end
    end

    def link_to_actions(ctx)
      "#{_edit(ctx)} #{_delete(ctx)}".html_safe
    end

    private

      def _edit(ctx)
        link_to 'Edit', href(ctx, "/#{ctx.class.name.underscore.pluralize}/:id/edit")
      end

      def _delete(ctx)
        link_to 'Delete', href(ctx, "/#{ctx.class.name.underscore.pluralize}/:id"), method: :delete, confirm: 'Are you sure?'
      end

  end
end
