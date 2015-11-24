class Widget < ActiveRecord::Base
  alias_attribute :to_s, :title
end
