# frozen_string_literal: true

require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define do
  create_table :test_models, force: true do |t|
    t.integer :column_1
    t.integer :column_2
  end
end

class TestModel < ActiveRecord::Base
  include RequiredQueryAttributes::Model
end
