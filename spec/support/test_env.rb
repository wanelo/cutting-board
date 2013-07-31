require 'fileutils'

module TestEnv

  PWD = ENV['PWD']

  def self.setup_rspec(config)
    config.before(:each) do
      TestEnv.setup
    end

    config.after(:suite) do
      TestEnv.clean!
    end
  end

  def self.test_dir
    File.expand_path('tmp/project')
  end

  def self.setup
    FileUtils.mkdir_p(test_dir)
    ENV['PWD'] = test_dir
  end

  def self.clean!
    FileUtils.rm_rf('tmp')
    ENV['PWD'] = PWD
  end

end
