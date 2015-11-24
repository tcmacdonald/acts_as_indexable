module ActsAsIndexable
  module View
    extend ActiveSupport::Concern

    included do
      helper_method :decorated_attrs
    end

    protected

      def current_attrs
        @current_attrs ||= {
          id: {},
          to_s: {},
          created_at: {},
        }
      end

      def decorated_attrs
        @decorated_attrs ||= current_attrs.collect do |k,v|
          Attribute.new k, OpenStruct.new(v)
        end
      end

  end
end
