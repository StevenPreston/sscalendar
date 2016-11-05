# SSCalendar

[![Version](https://img.shields.io/cocoapods/v/SSCalendar.svg?style=flat)](http://cocoapods.org/pods/SSCalendar)
[![License](https://img.shields.io/cocoapods/l/SSCalendar.svg?style=flat)](http://cocoapods.org/pods/SSCalendar)
[![Platform](https://img.shields.io/cocoapods/p/SSCalendar.svg?style=flat)](http://cocoapods.org/pods/SSCalendar)

## Introduction

SSCalendar is a UI library that can be used to display a calendar of events within your app. This calendar library was originally built in 2013 for a project that required a calendar experience similar to the revamped Apple calendar app in iOS 7. At the time, I found very few calendar libraries and decided to build one. Note that this calendar is not designed as a picker but rather to display an existing set of events.

SSCalendar provides 3 different calendar views:

### Annual view
![Annual](https://github.com/StevenPreston/SSCalendar/blob/master/Screenshots/1.gif)

### Monthly view
![Monthly](https://github.com/StevenPreston/SSCalendar/blob/master/Screenshots/2.gif)

### Weekly and daily view
![Daily/Weekly](https://github.com/StevenPreston/SSCalendar/blob/master/Screenshots/3.gif)

## Shortfalls

If any interest is shown in the library then I'll work on improving it. In its current state its limited and poorly constructed. Some areas that need work:

- No tests
- Inelegent and poorly constructed
- Difficult to customize
- Limited features

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 8 and up.

## Installation

SSCalendar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SSCalendar"
```

## Usage

First, import the module:

```swift
import SSCalendar
```

Then, generate data to populate the calendar. Data should be in the form of an array of SSEvent objects:

```swift
private func generateEvents() -> [SSEvent] {
  var events: [SSEvent] = []
  for year in 2016...2021 {
    for _ in 1...200 {
      events.append(generateEvent(year));
    }
  }
  return events
}

private func generateEvent(year: Int) -> SSEvent {
  let month = Int(arc4random_uniform(12)) + 1
  let day = Int(arc4random_uniform(28)) + 1

  let event = SSEvent()
  event.startDate = SSCalendarUtils.dateWithYear(year, month: month, day: day)
  event.startTime = "09:00"
  event.name = "Example Event"
  event.desc = "Details of the event"

  return event
}
```

Next, instantiate the type of calendar view controller (SSCalendarAnnualViewController or SSCalendarMonthlyViewController) that you want to display; along with the array of events:

```swift
let annualViewController = SSCalendarAnnualViewController(events: generateEvents())
let navigationController = UINavigationController(rootViewController: annualViewController)
navigationController.navigationBar.translucent = false
self.presentViewController(navigationController, animated: true, completion: nil)
```

## Author

Steven Preston, stevenpreston@stellar16.com

## License

SSCalendar is available under the MIT license. See the LICENSE file for more info.
