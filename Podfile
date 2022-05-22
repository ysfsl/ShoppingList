platform :ios, '15.0'

def core
  pod 'SwiftLint'
  pod "Resolver"
end

def networking
  pod 'Moya/Combine', '~> 15.0'
end

def ui
  pod 'SwiftAlertView', '~> 2.2.1'
end

target 'ShoppingList' do
  use_frameworks!
  core
  networking
  ui
  
  target 'ShoppingListTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ShoppingListUITests' do
    # Pods for testing
  end

end
