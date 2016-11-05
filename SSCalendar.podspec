#
# Be sure to run `pod lib lint SSCalendar.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'SSCalendar'
  s.version          = '0.0.1'
  s.summary          = 'A calendar UI library that somewhat mimics a stripped down version of the default calendar app experience.'

  s.description      = <<-DESC
SSCalendar is a UI library that can be used to display a calendar of events within your app. This calendar library was originally built in 2013 for a project that required a calendar experience similar to the revamped Apple calendar app introduced in iOS 7. At the time, I found very few comprehensive calendar libraries and as a result decided to build one. SSCalendar provides 3 different calendar views - an annual view, monthly view and weekly/daily view. Note that this calendar is not designed as a picker but rather to display an existing set of events.
                       DESC

  s.homepage         = 'https://github.com/StevenPreston/SSCalendar'
  s.screenshots      = 'https://github.com/StevenPreston/SSCalendar/raw/master/Screenshots/1.gif', 'https://github.com/StevenPreston/SSCalendar/raw/master/Screenshots/2.gif', 'https://github.com/StevenPreston/SSCalendar/raw/master/Screenshots/3.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Steven Preston' => 'stevenpreston@stellar16.com' }
  s.source           = { :git => 'https://github.com/StevenPreston/SSCalendar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/stevenpreston1'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SSCalendar/Classes/**/*'
  
  s.resource_bundles = {
     'SSCalendar' => ['SSCalendar/Classes/**/*.xib']
  }
end
