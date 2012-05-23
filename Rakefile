$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  app.name = 'AFNetworking'
  app.device_family = [:iphone, :ipad]

  app.pods do
    dependency 'AFNetworking'
  end
end
