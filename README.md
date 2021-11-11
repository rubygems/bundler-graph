# Bundler Graph plugin

`graph` generates a PNG file of the current `Gemfile` as a dependency graph.
`graph` requires the ruby-graphviz gem (and its dependencies).

The associated gems must also be installed via `bundle install`.

## Installation

Add this line to your application's Gemfile:

```ruby
plugin 'bundler-graph'
```

And then execute:

    $ bundle install

## Usage

```
bundle graph [--file=FILE]
             [--format=FORMAT]
             [--requirements]
             [--version]
             [--without=GROUP GROUP]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rubygems/bundler-graph.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
