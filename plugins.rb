# frozen_string_literal: true

require "bundler/viz"
Bundler::Plugin::API.command("viz", Bundler::Viz::Command)
