require 'cutting-board'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f unless /_spec\.rb$/.match(f) }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # run rspec with --seed 1234 to run in a fixed order
  config.order = 'random'

  TestEnv.setup_rspec(config)
end
