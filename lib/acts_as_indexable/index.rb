module ActsAsIndexable
  module Index
    extend ActiveSupport::Concern

    included do
      helper_method :decorated_attrs
    end

    protected

      def current_attrs
        @current_attrs ||= [
          { key: :id, label: 'ID' },
          { key: :to_s, label: 'Name' },
          { key: :created_at }
        ]
      end

      def decorated_attrs
        @decorated_attrs ||= current_attrs.collect do |attr|
          Column.new OpenStruct.new(attr)
        end
      end

  end
end
