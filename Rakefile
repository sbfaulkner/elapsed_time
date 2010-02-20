require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the elapsed_time plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the elapsed_time plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ElapsedTime'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rcov/rcovtask'

namespace :test do
  desc 'Measures test coverage'
  task :coverage => 'coverage:run' do
    system("open #{File.join(File.dirname(__FILE__), 'test', 'coverage', 'index.html')}") if PLATFORM['darwin']
  end

  namespace :coverage do
    Rcov::RcovTask.new('run') do |t|
      t.libs << "test"
      t.test_files = FileList["test/*_test.rb"]
      t.output_dir = "test/coverage"
      t.verbose = true
      t.rcov_opts = ['-x"gems/*,/Library/Ruby/*"']
    end
  end
end
