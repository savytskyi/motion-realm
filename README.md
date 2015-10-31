# motion-realm

TODO: Write a gem description
`motion-realm` gem has been made to Rubyfy Realm's syntax a little bit. You will
still need to read Realm's docs in order to understand how it works. Also because
of Realm's specific, we still have to vendor Objective-C schema files.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-realm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-realm

## Usage

TODO: Write usage instructions here

By default if you are going to save an object without setting all its properties
to some value, they will be set to:
Number or Mixed property to 0
Array properties to []
All other properties will be set to Nil.

If you want to change this behaviour, you can use class method `default_values`.
For example:
def self.default_values
  {
    bool_prop: true,
    int_prop: 1
  }
end

## Migrations

To migrate your DB to a newer schema version, you can use `RLMRealmConfiguration.migrate_to_version(new_version, &block)` method.
It is a good idea to use non-nested `if` conditions, because some user
may update your app rarely, and they may accidentally skip migration from X to Y
schema version:


RLMRealmConfiguration.migrate_to_version(3) do |migration, old_version|
  migration.enumerate "YourClassName" do |old_object, new_object|
    # user has not updated his app to the 1st schema version yet:
    if old_version < 1
      # migrate the object to 1st version
    end

    # user had 1st version of the schema already:
    if old_version < 2
      # migrate the object to the 2nd version
    end

    # user had latest available schema. Update him to a newer one:
    if old_version < 3
      # migrate the object to the 3rd version
    end
  end
end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
