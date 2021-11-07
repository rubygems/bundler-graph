# frozen_string_literal: true

require_relative "graph"

require "bundler"
require "optparse"

module Bundler
  module Visualize
    class Command
      def initialize
        Bundler.ui = UI::Shell.new
      end

      def exec(_command, args)
        options = parse_options(args)
        options = defaults.merge(options)

        output_file = File.expand_path(options[:file])

        graph = Graph.new(Bundler.load, output_file, options[:version], options[:requirements], options[:format], options[:without])
        graph.visualize
      rescue StandardError => e
        raise unless e.message =~ /GraphViz not installed or dot not in PATH/

        Bundler.ui.error e.message
        Bundler.ui.warn "Please install GraphViz. On a Mac with Homebrew, you can run `brew install graphviz`."
      end

      private

      def parse_options(args)
        options = {}
        parser = option_parser(options)
        parser.parse!(args)
        options
      end

      def option_parser(options)
        OptionParser.new do |o|
          o.banner = <<~B
            Usage:
              bundle visualize [OPTIONS]
            'visualize' generates a PNG file of the current Gemfile as a dependency graph.
            'visualize' requires the ruby-graphviz gem (and its dependencies).
            The associated gems must also be installed via 'bundle install'.
          B
          o.on("-f", "--file FILE", "The name to use for the generated file. see format option") do |arg|
            options[:file] = arg
          end

          o.on("-F", "--format FORMAT", "This is output format option. Supported format is png, jpg, svg, dot ...") do |arg|
            options[:format] = arg
          end

          o.on("-R", "--requirements", "Set to show the version of each required dependency.") do
            options[:requirements] = true
          end

          o.on("-v", "--version", "Set to show each gem version.") do
            options[:version] = true
          end

          o.on("-W", "--without GROUP[,GROUP...]", Array, "Exclude gems that are part of the specified named group.") do |arg|
            options[:without] = arg
          end
        end
      end

      def defaults
        {
          file: "gem_graph",
          format: "png",
          requirements: false,
          version: false,
          without: []
        }
      end
    end
  end
end
