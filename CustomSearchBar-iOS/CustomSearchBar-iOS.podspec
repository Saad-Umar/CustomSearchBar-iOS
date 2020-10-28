Pod::Spec.new do |spec|
  spec.name         = 'CustomSearchBar-iOS'
  spec.version      = '1.0.0'
  spec.authors      = { 
    'Saad Umar' => 'saad.umar93@gmail.com',
  }
  spec.license      = { 
    :type => 'MIT',
    :file => 'LICENSE' 
  }
  spec.homepage     = 'https://github.com/Saad-Umar/CustomSearchBar-iOS'
  spec.source       = { 
    :git => 'https://github.com/Saad-Umar/CustomSearchBar-iOS.git', 
    :branch => 'master',
    :tag => spec.version.to_s 
  }
  spec.summary      = 'This project lets you customise your search bar with an underline'
  spec.ios.deployment_target = '13.0'
  spec.source_files = "CustomSearchBar-iOS/**/*.{h,m}"

end