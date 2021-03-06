# atlas

[![Build Status](https://travis-ci.org/nickcharlton/atlas-ruby.svg?branch=master)](https://travis-ci.org/nickcharlton/atlas-ruby)
[![Code Climate](https://codeclimate.com/github/nickcharlton/atlas-ruby/badges/gpa.svg)](https://codeclimate.com/github/nickcharlton/atlas-ruby)
[![Test Coverage](https://codeclimate.com/github/nickcharlton/atlas-ruby/badges/coverage.svg)](https://codeclimate.com/github/nickcharlton/atlas-ruby)

Atlas is a Ruby client for [Hashicorp][]'s [Atlas][].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atlas'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atlas

## Usage

`atlas` uses an approach similar ActiveRecord:

```ruby
# first, login with the token from Atlas
Atlas.configure do |config|
  config.access_token = 'token'
end

# then you can load in users (creating, updating, etc isn't supported by Atlas)
user = Atlas::User.find('nickcharlton')
#=> <Atlas::User username=nickcharlton...>
```

More likely, you'll want to grab a box and work with it:

```ruby
box = Atlas::Box.find('nickcharlton/example-box')
#=> <Atlas::Box name=example-box'...>

# creating a new version
version = box.create_version(version: '1.0.0')
#=> <Atlas::BoxVersion version: '1.0.0')

# add a provider to that version
provider = version.create_provider(name: 'virtualbox')

# upload a file for the version
provider.upload(File.open('box_name.box'))

# set the version to be released
version.release
```

It aims to support most of the functionality listed in the [Atlas API
Documentation][].

## Contributing

1. Fork it ( https://github.com/nickcharlton/atlas-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

Copyright (c) 2015 Nick Charlton <nick@nickcharlton.net>

[Hashicorp]: https://www.hashicorp.com
[Atlas]: https://atlas.hashicorp.com
[Atlas API Documentation]: https://atlas.hashicorp.com/docs
