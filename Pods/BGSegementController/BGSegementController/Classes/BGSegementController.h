//
//  BGSegementController.h
//  Pods
//
//  Created by iOSzhb on 2016/5/18.
//
//

#import <UIKit/UIKit.h>

@interface BGSegementController : UIViewController
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, assign) CGFloat tarBarHeight;
@property (nonatomic, strong) UIFont *itemFone;

- (instancetype)initWithFrame:(CGRect)frame;
+ (instancetype)bgSegementControllerWithFrame:(CGRect)frame;
- (void)setColor:(UIColor *)color forState:(UIControlState)state;
@end
