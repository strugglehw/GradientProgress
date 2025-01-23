# GradientProgress 
[![CI Status](https://img.shields.io/travis/atao/GradientProgress.svg?style=flat)](https://travis-ci.org/atao/GradientProgress)
[![Version](https://img.shields.io/cocoapods/v/GradientProgress.svg?style=flat)](https://cocoapods.org/pods/GradientProgress)
[![License](https://img.shields.io/cocoapods/l/GradientProgress.svg?style=flat)](https://cocoapods.org/pods/GradientProgress)
[![Platform](https://img.shields.io/cocoapods/p/GradientProgress.svg?style=flat)](https://cocoapods.org/pods/GradientProgress)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GradientProgress is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GradientProgress'
```

## Author

atao, xintaoxxxx@163.com

## License

GradientProgress is available under the MIT license. See the LICENSE file for more info.

swift 5实现的渐变颜色的圆环进度条
实例：

        let gpView = GradientProgressView();
        //默认是黑色，结合要用的情景设置背景
        gpView.backgroundColor = UIColor.white
        
        //设置渐变的方向
        gpView.gradientStart = .leftTop
        //设置渐变的颜色组
        gpView.gradientColors = [UIColor.yellow,UIColor.blue,UIColor.red];
