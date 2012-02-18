# Valcro

Valcro is the simple validation library for Ruby. It provides 

* A declarative way to describe what makes an object valid
* A way to declare Validation classes encapsulating validations to be shared
  across objects
* A method for running validations against an instance of your object
* A method for checking whether an object is valid
* Visibility into what validations failed

It is similar in spirit to ActiveModel's or Sequel's validations, but far
simpler and with a slightly different API. It does not provide validation
helpers such as `validates_presence_of` or similar.

## Example

```ruby
class Dog
  include Valcro

  attr_accessor :name

  def validate
    super
    errors.add(:name, 'must be present') unless name
  end
end

 dog = Dog.new
 dog.validate
 dog.valid?
 => false 
dog.errors[:name]
 => ["must be present"]
 dog.error_messages
 => "name must be present"
```

Unlike other ruby libraries, you must call validate explicitely to check for
validity of objects.

## License

Valcro is copyright (c) Harold Giménez and is released under the terms of the
MIT License found in the LICENSE file.
