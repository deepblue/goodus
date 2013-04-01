# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

require 'bundler'
Bundler.require

require 'bubble-wrap/media'
require 'bubble-wrap/reactor'
#require 'motion-pixate-observer'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Goodus'
  app.version = '0.1'
  app.identifier = 'com.deepblue.goodus'

  app.frameworks += %w(AVFoundation)
  app.pixate.framework = 'vendor/PXEngine.framework'

  app.pods do
    pod 'NanoStore', '~> 2.6.0'
  end
end
