module RequiredQueryAttributes
  def self.included(base)
    base.send :extend, Model::ClassMethods
  end

  # Extensions to `ActiveRecord::Base`.
  # We want to have the smallest possible footprint here.
  module Model
    module ClassMethods
      # Declare this in your model to enforce that the provided attribute
      # must be used in at least one condition on SELECT statements.
      #
      # Parameters:
      #
      # - name - Attribute to enforce presence in queries.
      #
      # @api public
      def require_query_attribute(attribute)
        @required_query_attributes ||= []
        @required_query_attributes << attribute.to_s
      end

      attr_reader :required_query_attributes

      def self.extended(base)
        # Attach our own RequiredQueryAttributes::Relation
        # to existing delegate factories
        base.instance_eval do
          @relation_delegate_cache.values.each do |klass|
            klass.include Relation
          end
        end
      end
    end
  end
end
