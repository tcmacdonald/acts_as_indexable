module ActsAsIndexable
  class Attribute
    include ActionView::Helpers::UrlHelper

    attr_accessor :key,
                  :label,
                  :attrs,
                  :path

    def initialize(key, attrs={})
      @key = key
      @attrs = attrs
      @label = @attrs.try(:[], :label) || @key.to_s.humanize
      @path = @attrs.try(:[], :link_to)
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
      @attrs.to_h.collect do |k,v|
        label = v.try(:[], :label) || k.to_s.humanize
        opts = {}
        if k == :delete
          opts[:data] = { method: :delete, confirm: 'Are you sure?' }
          path = v.try(:[], :link_to) || "/#{ctx.class.name.underscore.pluralize}/:id"
        else
          path = v.try(:[], :link_to) || "/#{ctx.class.name.underscore.pluralize}/:id/#{k}"
        end

        link_to label, href(ctx, path), opts.merge(v.except(:link_to, :label))
      end.join().html_safe
    end

  end
end
