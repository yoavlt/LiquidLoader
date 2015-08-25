# LiquidLoader
LiquidLoader is the loader UI components with liquid animation, inspired by [Spinner Loader - Gooey light Effect](http://www.materialup.com/posts/spinner-loader-gooey-light-effect)

[![CI Status](http://img.shields.io/travis/yoavlt/LiquidLoader.svg?style=flat)](https://travis-ci.org/yoavlt/LiquidLoader)
[![Version](https://img.shields.io/cocoapods/v/LiquidLoader.svg?style=flat)](http://cocoapods.org/pods/LiquidLoader)
[![License](https://img.shields.io/cocoapods/l/LiquidLoader.svg?style=flat)](http://cocoapods.org/pods/LiquidLoader)
[![Platform](https://img.shields.io/cocoapods/p/LiquidLoader.svg?style=flat)](http://cocoapods.org/pods/LiquidLoader)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)]
(https://github.com/Carthage/Carthage)

## GrowCircle
![GrowCircle](https://github.com/yoavlt/LiquidLoader/blob/master/Demo/grow-circle.gif?raw=true)

## GrowLine
![GrowLine](https://github.com/yoavlt/LiquidLoader/blob/master/Demo/grow-line.gif?raw=true)


## Usage

```swift
let loader = LiquidLoader(frame: loaderFrame, effect: .GrowCircle(circleColor))
view.addSubview(loader)
```

### Show/Hide

You can show and hide a loader.

```swift
loader.show()
loader.hide()
```

### Effect Type
You can use the following effects.
* .GrowCircle
* .GrowLine
* .Circle
* .Line

If you want to avoid grow effects, you should use `.Circle` or `.Line`.

## Installation

LiquidLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LiquidLoader"
```

or, if you use [Carthage](https://github.com/Carthage/Carthage), add the following line to your `Carthage` file.

```
github "yoavlt/LiquidLoader"
```

## License

LiquidLoader is available under the MIT license. See the LICENSE file for more info.
