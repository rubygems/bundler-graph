Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

RSpec.configure do |c|
  c.include Spec::Helpers
end
