$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  app.name = 'AFNetworking'
  app.device_family = [:iphone, :ipad]

  app.pods do
    dependency 'AFNetworking'
    dependency 'SSPullToRefresh'
  end
end

desc "Clean the vendor build folder"
task :vendorclean => [:clean] do
  sh "rm", "-rf", "vendor/build"
  sh "rm", "-rf", "vendor/Pods"
end

task :run => [:default]
