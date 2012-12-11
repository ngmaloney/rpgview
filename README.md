# Rpgview

RPGView is a ruby based sql generator for creating a Postgresql view wrapper around a gnarly legacy table. It includes all the Postgresql 9.x trigger goodness for interacting directly with the view in your Rails app.

## Installation

Add this line to your application's Gemfile:

    gem 'rpgview'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rpgview

## Usage

rpgview /path/to/mapping.yaml

The mapping.yaml file should looke something like:

    mapping:
      table: 'radcheck'
      view: 'radius_check'
      mappings:
        legacyid: 'id'
        username: 'user_name'
        attribute: 'attribute_type'
        op: 'operator'
        value: 'attribute_value'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
