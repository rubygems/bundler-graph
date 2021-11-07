# bundler-visualize

A bundler plugin that generates a visual representation of your gem dependencies.

## Installation

While this is a gem, you need to install it as a [Bundler plugin](https://bundler.io/v1.16/guides/bundler_plugins.html):

    $ bundler plugin install bundler-visualize

You also need to install [GraphViz](https://www.graphviz.org).

## Usage

    $ bundle visualize

## Development

1. Clone the repo
1. run `rake` to run linter and tests

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rubygems/bundler-viz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `bundler-visualize` project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fatkodima/bundler-visualize/blob/master/CODE_OF_CONDUCT.md).
