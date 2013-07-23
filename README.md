# Travis iOS

## Foreword

Universal (iPhone & iPad) iOS application to always keep an eye on your builds running on Travis.

This applications uses the official Travis API.

The main goal of this application is for the Fanatics to learn iOS and Objective-C by actually doing something.

We handcrafted this app with all our love but as it is still Work in Progress, feel free to [contribute](#contribute) by making a pull request or opening an issue!

## Usage

### Installation

W.I.P

### Tests

Travis iOS uses the latest Testing Framework released by Apple with iOS 7.0: XCTest.

You can run the tests using [XCode](#xcode) or with the [Terminal](#terminal).

#### XCode

* Follow the [Installation](#installation) instructions
* Open the `travis_ios.xcworkspace` file
* In the menu bar, click on `Product` > `Test` or simply use the shortcut ` + U`
* Wait and See!

#### Terminal

* Follow the [Installation](#installation) instructions
* Go to the project's folder
* run ```shell xcodebuild -target travis_ios -scheme travis_ios -sdk iphonesimulator7.0 test```


## Contribute

This is Github folks!

If you find a *bug*, open an Issue.

If you want to add/change/hack/fix/improve/whatever something, make a Pull Request:

* Fork this repository
* Create a feature branch on your fork, we just love [git-flow](http://nvie.com/posts/a-successful-git-branching-model/)
* Do your stuff and pay attention to the following:
 * Your code should be documented using [Tomdoc](http://tomdoc.org)
 * You should follow [Apple's Objective-C Conventions](http://developer.apple.com/library/ios/#documentation/cocoa/conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html)
 * Update the CHANGELOG accordingly
* Make a Pull Request, we will *always* respond, and try to do it fast.
