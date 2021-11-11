# frozen_string_literal: true

require "bundler/plugin/api"
require "optparse"
require_relative "dep_graph"

module Bundler
  class GraphCLI < Plugin::API

    command "graph"

    def exec(command, argv)
      # make sure we get the right `graphviz`. There is also a `graphviz`
      # gem we're not built to support
      gem "ruby-graphviz"
      require "graphviz"

      options = {
        file: "gem_graph",
        format: "png",
        requirements: false,
        version: false,
        without: ""
      }
      opt = OptionParser.new
      opt.on('-f', '--file FILE', 'The name to use for the generated file. See `--format` option') {|v| options[:file] = v }
      opt.on('-F', '--format FORMAT', 'This is output format option. Supported format is png, jpg, svg, dot ...') {|v| options[:format] = v }
      opt.on('-R', '--requirements', 'Set to show the version of each required dependency.') {|v| options[:requirements] = true }
      opt.on('-v', '--version', 'Set to show each gem version.') {|v| options[:version] = true }
      opt.on('-W', '--without GROUP[:GROUP...]', 'Exclude gems that are part of the specified named group.') {|v| options[:without] = v }
      opt.parse!(argv)

      options[:without] = options[:without].tr(" ", ":").split(":")
      output_file = File.expand_path(options[:file])

      graph = DepGraph.new(Bundler.load, output_file, options[:version], options[:requirements], options[:format], options[:without])
      graph.viz
    rescue LoadError => e
      Bundler.ui.error e.inspect
      Bundler.ui.warn "Make sure you have the graphviz ruby gem. You can install it with:"
      Bundler.ui.warn "`gem install ruby-graphviz`"
    rescue StandardError => e
      raise unless e.message =~ /GraphViz not installed or dot not in PATH/
      Bundler.ui.error e.message
      Bundler.ui.warn "Please install GraphViz. On a Mac with Homebrew, you can run `brew install graphviz`."
    end
  end
end
