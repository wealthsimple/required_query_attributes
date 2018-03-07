# frozen_string_literal: true

require 'active_record'

require 'required_query_attributes/model'
require 'required_query_attributes/relation'
require 'required_query_attributes/version'

module RequiredQueryAttributes
  def self.included(base)
    base.send :extend, Model::ClassMethods
  end
end
