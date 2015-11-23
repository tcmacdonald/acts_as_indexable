module ActsAsIndexable
  class Column

    attr_accessor :key, :label, :attrs

    def initialize(obj, *attrs)
      @key = obj.try(:[], :key).to_sym
      @label = obj.try(:[], :label) || @key.to_s.humanize
      @attrs = attrs
    end

    def l(obj)
      obj.send(@key)
    end

  end
end
