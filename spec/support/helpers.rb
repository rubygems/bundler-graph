require "open3"

# https://github.com/duckinator/bundler-viz/blob/master/test/visualize_test.rb#L126
module Spec
  module Helpers
    def install_gemfile(content)
      File.open("Gemfile", "w") do |f|
        f.write(content)
      end
      run_command("bundle install")
    end

    def run_command(command)
      output = nil
      Bundler.with_unbundled_env do
        output, status = Open3.capture2e(command)

        raise StandardError, "#{command} failed: #{output}" unless status.success?
      end
      output
    end

    # https://github.com/rubygems/rubygems/blob/master/bundler/spec/support/helpers.rb#L271
    def strip_whitespace(str)
      # Trim the leading spaces
      spaces = str[/\A\s+/, 0] || ""
      str.gsub(/^#{spaces}/, "")
    end
  end
end
