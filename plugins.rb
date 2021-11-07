# frozen_string_literal: true

require "bundler/visualize"
Bundler::Plugin::API.command("visualize", Bundler::Visualize::Command)
