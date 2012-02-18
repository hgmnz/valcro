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
require 'valcro'

class Dog
  include Valcro

  attr_accessor :name

  def validate
    super
    errors.add(:name, 'must be great') unless name =~ /super|great|cool/
  end
end

dog = Dog.new
dog.name = 'spike'
dog.validate
dog.valid?
 => false 
dog.errors[:name]
 => ["must be great"]
dog.error_messages
 => "name must be great"
```

Unlike other ruby libraries, you must call validate explicitely to check for
validity of objects.

### Sharing validators

You may also have Cats in your system, which share the same validation. Valcro lets you encapsulate validations in an object with the following contract:

* It is constructed with the object being validated
* It responds to `call`, which receives a `Valcro::ErrorList`. Add validation errors to this object.

```ruby
class GreatNameValidator
  def initialize(thing_with_name)
    @thing_with_name = thing_with_name
  end

  def call(errors)
    errors.add(:name, 'must be great') unless @thing_with_name.name =~ /super|great|cool/
  end
end

class Dog
  include Valcro
  attr_accessor :name
  validates_with GreatNameValidator
end

class Cat
  include Valcro
  attr_accessor :name
  validates_with GreatNameValidator
end
```

## License

Valcro is copyright (c) Harold Giménez and is released under the terms of the
MIT License found in the LICENSE file.
