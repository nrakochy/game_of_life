require 'opal'
require 'opal-jquery'
require 'rspec/core/rake_task'

 RSpec::Core::RakeTask.new do |task|
   task.rspec_opts = ['--color', '--format', 'doc']
  end

 desc "Build our app to conway.js"

 task :build do
   env = Opal::Environment.new
     env.append_path “app/lib”

        File.open("conway.js", "w+") do |out|
            out << env["game_of_life"].to_s
        end
 end

