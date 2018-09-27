Pod::Spec.new do |s|
          #1.
          s.name               = "CoreDataBC"
          #2.
          s.version            = "1.0.0"
          #3.  
          s.summary         = "A high level framework that eases the use of CoreData"
          #4.
          s.homepage        = "https://bycyril.com/opensource"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "By Cyril"
          #7.
          s.platform            = :ios, "11.0"
          #8.
          s.source              = { :git => "https://github.com/cyrilivargarcia/CoreDataBC.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "CoreDataBC", "CoreDataBC/**/*.{h,m,swift}"
    end