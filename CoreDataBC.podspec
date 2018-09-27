Pod::Spec.new do |s|
  s.name             = 'CoreDataBC'
  s.version          = '1.1'
  s.summary          = 'A high level framework for CoreData'
 
  s.description      = <<-DESC
A high level framework that eases the use of CoreData.
                       DESC
 
  s.homepage         = 'https://github.com/cyrilivargarcia/CoreDataBC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Cyril' => 'Garcia' }
  s.source           = { :git => 'https://github.com/cyrilivargarcia/CoreDataBC.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.source_files = 'CoreDataBC/*.swift'
  s.swift_version = '3.2'
 
end