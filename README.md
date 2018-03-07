# RequiredQueryAttributes [![CircleCI](https://circleci.com/gh/wealthsimple/required_query_attributes.svg?style=svg)](https://circleci.com/gh/wealthsimple/required_query_attributes)

Enforce presence of specific columns in ActiveRecord queries.

## Description 

If you have a `records` table like this:

```ruby
create_table 'records' do |t|
  t.date     'date'
  t.string   'text'
end
```

You might want to make sure that `SELECT` queries always provide a predicate condition on `date`.

It could be because you have a very large table, and your only good index is on `date`.

Or maybe your data is partitioned by `date`, and thus not providing it will trigger full table scan.

`RequiredQueryAttributes` ensures all `SELECT` queries provide at least one predicate condition on the desired columns, or they will fail with an exception:

```ruby
RequiredQueryAttributes::RequiredAttributeMissing:
  Required attributes ["date"] missing from query:
    SELECT "records".* FROM "records" WHERE "records"."text" = 'string_to_find'
```

## Installation

Add this line to your application's `Gemfile` and execute `bundle`:

```ruby
gem 'required_query_attributes'
```

## Usage

Using the same `records` example:

```ruby
create_table 'records' do |t|
  t.date     'date'
  t.string   'text'
end
```

Configure your class:

```ruby
class Record < ActiveRecord::Base
  include RequiredQueryAttributes
 
  require_query_attribute :date
 
  # Add additional attributes if desired
  # require_query_attribute :text
end
```

Profit.

## FYI

This gem tries to do its job as cleanly as possible, only changing `ActiveRecord` behaviour when necessary.

There are no global changes to `ActiveRecord`: only models which you choose to install `RequiredQueryAttributes` are affected.
