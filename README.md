# LiquidLoader
LiquidLoader is the loader UI components with liquid animation, inspired by [Spinner Loader - Gooey light Effect](http://www.materialup.com/posts/spinner-loader-gooey-light-effect)

[![CI Status](http://img.shields.io/travis/Takuma Yoshida/LiquidLoader.svg?style=flat)](https://travis-ci.org/Takuma Yoshida/LiquidLoader)
[![Version](https://img.shields.io/cocoapods/v/LiquidLoader.svg?style=flat)](http://cocoapods.org/pods/LiquidLoader)
[![License](https://img.shields.io/cocoapods/l/LiquidLoader.svg?style=flat)](http://cocoapods.org/pods/LiquidLoader)
[![Platform](https://img.shields.io/cocoapods/p/LiquidLoader.svg?style=flat)](http://cocoapods.org/pods/LiquidLoader)

## GrowCircle
![GrowCircle](https://github.com/yoavlt/LiquidLoader/blob/master/Demo/grow-circle.gif?raw=true)

## GrowLine
![GrowLine](https://github.com/yoavlt/LiquidLoader/blob/master/Demo/grow-line.gif?raw=true)


## Usage

```swift:
let loader = LiquidLoader(frame: loaderFrame, effect: .GrowCircle(circleColor))
view.addSubview(loader)
```

### Show/Hide

```swift:
loader.show()
loader.hide()
```

### Effect Type
You can use the following effects.
* .GrowCircle
* .GrowLine
* .Circle
* .Line

If you avoid grow effect, you should use `.Circle` and `.Line`.

## Installation

LiquidLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LiquidLoader"
```

## License

LiquidLoader is available under the MIT license. See the LICENSE file for more info.
