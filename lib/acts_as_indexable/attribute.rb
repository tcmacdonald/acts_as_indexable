module ActsAsIndexable
  class Attribute
    include ActionView::Helpers::UrlHelper

    attr_accessor :key,
                  :label,
                  :attrs,
                  :format,
                  :partial,
                  :path,
                  :span,
                  :visible,
                  :to_s

    def initialize(*args, &block)
      ActionView::Base.send(:include, Rails.application.routes.url_helpers)
      @helper = ActionController::Base.helpers
      @view = ActionView::Base.new(ActionController::Base.view_paths)
      extract_vars(*args, &block)
    end

    def render(*args, &block)
      if @partial.present?
        render_partial(*args, &block)
      else
        render_column(*args, &block)
      end
    end

    def klass
      @attrs.try(:[], :class)
    end

    def is_visible?(obj)
      if @visible.respond_to?(:call)
        @visible.try(:call, obj)
      else
        @visible.nil? ? true : @visible
      end
    end

    def colspan(obj)
      if @span.respond_to?(:call)
        @span.try(:call, obj)
      else
        @span || nil
      end
    end

    protected

      def render_partial(ctx, render_links: true, format: :html)
        formats = [:html].unshift(format).uniq
        @view.render(partial: @partial, object: ctx, formats: formats).squish
      end

      def render_column(ctx, render_links: true, format: :html)
        if @key == :actions
          link_to_actions(ctx) if render_links
        else
          @helper.link_to_if (render_links && @path.present?), l(ctx), href(ctx)
        end
      end

    private

      def l(ctx)
        if @to_s.present?
          if @to_s.respond_to?(:call)
            @to_s.call(ctx)
          else
            @to_s
          end
        elsif @format.present?
          if @format.respond_to?(:call)
            @format.call(ctx)
          elsif @format == :currency
            @helper.number_to_currency ctx.send(@key)
          else
            v = ctx.send(@key)
            if v.kind_of?(Date) || v.kind_of?(Time)
              I18n.l v, format: @format
            else
              v
            end
          end
        else
          ctx.send(@key)
        end
      end

      def href(ctx, href=nil)
        path = href || @path
        if path.present?
          if path.try(:respond_to?, :call)
            path.call(ctx)
          elsif path.to_s == 'email'
            "mailto:#{ctx.send(@key).to_s}"
          elsif path.to_s == 'self'
            ctx
          else
            path.scan(/:[a-z_]*/).each do |attr|
              path = path.gsub(/#{attr}/, ctx.send(attr[1..-1].to_sym).to_s)
            end
            path
          end
        end
      end

      def link_to_actions(ctx)
        @attrs.to_h.select{|k,v| v.is_a?(Hash) }.collect do |k,v|
          label = v.try(:[], :label) || k.to_s.humanize
          opts = {}
          if k == :delete
            opts[:data] = { method: :delete, confirm: 'Are you sure?' }
            path = v.try(:[], :link_to) || "/#{ctx.class.name.underscore.pluralize}/:id"
          else
            path = v.try(:[], :link_to) || "/#{ctx.class.name.underscore.pluralize}/:id/#{k}"
          end

          @helper.link_to label, href(ctx, path), opts.merge(v.except(:link_to, :label))
        end.join('&nbsp;').html_safe
      end

      def extract_vars(key, attrs={})
        @key = key
        @attrs = attrs
        @label = @attrs.try(:[], :label) || @key.to_s.humanize
        @path = @attrs.try(:[], :link_to)
        @format = @attrs.try(:[], :format)
        @partial = @attrs.try(:[], :partial)
        @span = @attrs.try(:[], :colspan)
        @visible = @attrs.try(:[], :visible)
        @to_s = @attrs.try(:[], :to_s)
      end

  end
end
