# BGSegementController

[![Version](https://img.shields.io/cocoapods/v/BGSegementController.svg?style=flat)](http://cocoapods.org/pods/BGSegementController)
[![License](https://img.shields.io/cocoapods/l/BGSegementController.svg?style=flat)](http://cocoapods.org/pods/BGSegementController)
[![Platform](https://img.shields.io/cocoapods/p/BGSegementController.svg?style=flat)](http://cocoapods.org/pods/BGSegementController)

## 安装

* clone 仓库,打开Example中的.xcworkspace,可查看效果.
* clone 仓库后,将BGIndicateView.h/m , BGSegementController.h/m 四个文件拖入项目即可.(说明:BGIndicateView后期补充多种指示器的样式,用户也可自行添加)
* cocoaPods安装:
```ruby
pod "BGSegementController"
```

## 使用

* #import "BGSegementController.h"
* 初始化segementController.
* 设置segementController的viewControllers数组.(存放子控制器的数组)
* segementController作为其他控制的childViewController使用,勿忘下面操作.
```objc
[currenController.view addSubview:pagesContainer.view];
[currenController.view addChildViewController:pagesContainer];

//eg:
- (void)methodName
{
  [self.view addSubview:pagesContainer.view];
  [self addChildViewController:pagesContainer];
}
```

* BGSegementController目前通过实现scrollerView的delegate方法,控制显示效果.而我死来想去,正在通过kvo方式达到一样的效果.正在拼命写代码...(后期待上传)

## 后期会上传多个功能组件.敬请期待...

## 联系方法

* 邮箱:developzhb@163.com / zhb_mymail@163.com
* QQ: 1293750103

