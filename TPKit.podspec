#
# Be sure to run `pod lib lint TPKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TPKit"
  s.version          = "1.0"
  s.summary          = "A collection of useful shit"


# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                        A collection of useful shit (for me at least) written in Swift.
                       DESC

  s.homepage         = "https://github.com/tikhop/TPKit"
  s.license          = 'MIT'
  s.author           = { "Pavel Tikhonenko" => "hi@tikhop.com" }
  s.source           = { :git => "https://github.com/tikhop/TPKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.frameworks = 'UIKit' #, 'MapKit'
end
