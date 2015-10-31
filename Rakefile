# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require './lib/motion-realm'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motion-realm'

  app.libs << '/usr/lib/libc++.dylib'
  app.external_frameworks << 'vendor/realm/Realm.framework'
  app.vendor_project 'schemas', :static, :cflags => '-F ../vendor/realm/'
end
