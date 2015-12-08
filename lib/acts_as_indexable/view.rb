require 'csv'

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

      def render_exportable(collection)
        attrs = decorated_attrs.reject{|attr| attr.try(:key) == :actions }
        output = CSV.generate do |csv|
          # headers
          csv << attrs.collect(&:label)

          # rows
          collection.each do |obj|
            csv << attrs.collect do |attr|
              attr.render(obj, render_links: false, format: :csv)
            end
          end
        end

        filename = "#{request.path[1..-1].gsub(/\//,'-')}-#{Time.zone.now.to_i}.csv"
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
        render text: output
      end

  end
end
