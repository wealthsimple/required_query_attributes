module RequiredQueryAttributes
  class RequiredAttributeMissing < ActiveRecord::ActiveRecordError; end

  module Relation
    extend ActiveSupport::Concern

    # Intercepts calls to 'load', validating for required attributes before execution
    def load(*)
      required_query_attributes = @klass.required_query_attributes
      check_required_query_attributes(required_query_attributes) if required_query_attributes
      super
    end

    private

    def check_required_query_attributes(required_query_attributes)
      predicate_attributes = where_clause.send(:predicates).
        select { |node| node.left.relation.name == table_name }.
        map { |node| node.left.name }

      missing_names = required_query_attributes - predicate_attributes

      if missing_names.present?
        raise RequiredAttributeMissing,
              "Required attributes #{missing_names} missing from query: #{to_sql.truncate(200)}"
      end
    end
  end
end
