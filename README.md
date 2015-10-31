# motion-realm

[![Gem Version](https://badge.fury.io/rb/motion-realm.svg)](https://badge.fury.io/rb/motion-realm)

[![Code Climate](https://codeclimate.com/github/savytskyi/motion-realm/badges/gpa.svg)](https://codeclimate.com/github/savytskyi/motion-realm)

`motion-realm` gem has been made to Rubyfy Realm's syntax. You will
still need to read some Realm's docs in order to understand how it works. Also because
of Realm's specific, we still have to vendor Objective-C schema files.

## Realm setup

I would suggest compiling Realm from their sources available at https://github.com/realm/realm-cocoa

`git clone https://github.com/realm/realm-cocoa`
`cd realm-cocoa`
`sh build.sh build`

When build will be finished, copy `build/ios/Realm.framework` into your app's `vendor/realm` folder. Don't forget to create `schemas` folder that will contain your DB schema definitions.

Now we need to tell Rubymotion to include realm and schemas. In your `Rakefile` add:

`app.libs << '/usr/lib/libc++.dylib'`
`app.external_frameworks << 'vendor/realm/Realm.framework'`
`app.vendor_project 'schemas', :static, :cflags => '-F ../vendor/realm/'`

You can start using Realm in your project now.

## motion-realm installation

Add this line to your application's Gemfile:

    gem 'motion-realm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-realm

## Usage

### Schemas and Models

Your schemas should be defined in `/schemas` folder. Unfortunately because of
the Realm's specific we will have to use Objective-C here. You can check Realm's docs on models at https://realm.io/docs/objc/latest/#models

`schemas/schema.h`

```objective-c
#import <Realm/Realm.h>

@class Parent;

@interface Child : RLMObject

@property BOOL          likes_math;
@property NSInteger     favourite_number;
@property NSString     *name;
@property NSString     *sex;
@property NSDate       *birthday;
@property NSData       *some_data;

@property Parent *parent;

@end

RLM_ARRAY_TYPE(Child)

@interface Parent : RLMObject

@property NSString     *job;
@property NSString     *name;
@property NSString     *sex;
@property NSDate       *birthday;
@property BOOL          likes_ruby;
@property NSInteger     apps_in_appstore;
@property NSData       *some_data;

@property RLMArray<Child *> <Child> *children;

@end
```

And don't forget about implementation `.mm` file:

`schemas/schema.mm`

```objective-c
#import "schema.h"

@implementation Child
@end

@implementation Parent
@end
```

Now when we have schema defined, we can create `app/models/child.rb` and
`app/models/parent.rb`:

```ruby
class Child
  # it is important to include MotionRealm module in your model classes:
  include MotionRealm

  # if you want to set some default values, do it in this method:
  def self.default_values
    {
      likes_math: true,
    }
  end

  # indexes can be defined here:
  def self.indexes
    ["name", "favourite_number"]
  end

  # primary key, if needed:
  def self.primary_key
    "name"
  end
end

class Parent
  include MotionRealm
end
```

This is it! Schema and Models were defined, and everything is ready for usage!

### Create/Read/Update/Delete

```ruby
# create in-memory objects:`
child = Child.new
child.name = "John"

parent = Parent.create name: "Jack"
parent.children << child

# persist them:
RLMRealm.write do |realm|
  realm << child
  realm << parent
end

# find objects:
parent = Parent.where("name = 'Jack'").first

# or using predicates:
predicate = NSPredicate.predicateWithFormat "name == %@", "some cool name"
cool_parents = Parent.with_predicate predicate

# we have to update objects inside write block only:
RLMRealm.write do |realm|
  parent.name = 'Jack Smith'
end

# delete objects:
parent.delete

# or
RLMRealm.write do |realm|
  realm.delete parent
end

# delete all objects:
RLMRealm.write do |realm|
  realm.delete_all
end

# or all objects for a given class:
Parent.delete_all
```

### Saving objects

```ruby
result = RLMRealm.write do |realm|
  # add objects to realm, update objects, delete them here
end
# result is a Hash: { saved: true/false, error: error_if_any }


# RLMRealm.write is just a shorthand for:
realm = RLMRealm.default
realm.start_writing
  # add objects to realm, update objects, delete them here
realm.end_writing
```

By default if you are going to save an object without setting all its properties
to some value, they will be set to:

- Number or Mixed property to 0
- Array properties to []
- All other properties will be set to Nil.

If you want to change this behaviour, you can use class method `default_values`.
For example:

```ruby
def self.default_values
  {
    bool_prop: true,
    int_prop: 1
  }
end
```

### Notifications

You can post notifications each time realm data has been updated. To do it
just tell your realm that you want to add a notification:

```ruby
@notification_token = realm.add_notification do |notification, realm|
  # some your actions here
end
```

Don't forget to remove it when you won't need it anymore with:

```ruby
realm.remove_notification @notification_token
```

## Migrations

Sometimes we have to update DB schema. Realm's docs describe it very well at https://realm.io/docs/objc/latest/#migrations

To migrate your DB to a newer schema version, you can use `RLMRealmConfiguration.migrate_to_version(new_version, &block)` method.

It is a good idea to use non-nested `if` conditions, because some users
may update your app rarely, and they may accidentally skip migration from X to Y
schema version:

```ruby
RLMRealmConfiguration.migrate_to_version(3) do |migration, old_version|
  migration.enumerate "Parent" do |old_object, new_object|
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
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
