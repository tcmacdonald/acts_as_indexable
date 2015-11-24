module ActsAsIndexable
  class Attribute

    attr_accessor :key,
                  :label

    def initialize(obj, *attrs)
      @object = obj
      @key = @object.try(:[], :key).to_sym
      @label = @object.try(:[], :label) || @key.to_s.humanize
    end

    def l(ctx)
      ctx.send(@key)
    end

  end
end
