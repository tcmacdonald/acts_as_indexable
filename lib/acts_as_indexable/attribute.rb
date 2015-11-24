module ActsAsIndexable
  class Attribute

    attr_accessor :key,
                  :label,
                  :link_to

    def initialize(obj, *attrs)
      @object = obj
      @key = @object.try(:[], :key).to_sym
      @label = @object.try(:[], :label) || @key.to_s.humanize
      @link_to = @object.try(:[], :link_to)
    end

    def l(ctx)
      ctx.send(@key)
    end

    def href(ctx)
      if @link_to.present?
        if @link_to.to_s == 'self'
          ctx
        elsif
          @link_to.scan(/:[a-z]*/).each do |attr|
            @link_to.gsub!(/#{attr}/, ctx.send(attr[1..-1].to_sym).to_s)
          end
          @link_to
        end
      end
    end

  end
end
