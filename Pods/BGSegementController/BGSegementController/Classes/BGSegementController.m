//
//  BGSegementController.m
//  Pods
//
//  Created by iOSzhb on 2016/5/18.
//
//

#import "BGSegementController.h"
#import "BGIndicateView.h"


@interface BGSegementController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray<NSString *> *itemTitles;
@property (nonatomic, strong) NSArray<UIButton *> *itemViews;
@property (nonatomic, strong) NSArray<NSNumber *> *itemWidths;
@property (nonatomic, strong) NSArray<UIView *> *controllerViews;
@property (nonatomic, strong) UIScrollView *itemsScrollerView;
@property (nonatomic, strong) UIScrollView *viewsScrollerView;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, weak) UIButton *previosBtn;
@property (nonatomic, assign) NSInteger previosIndex;
@property (nonatomic, strong) BGIndicateView *indicateView;



@end

@implementation BGSegementController

static NSInteger btnnPrefix = 433;
static NSInteger viewPrefix = 533;
static CGFloat   itemMarginX = 10.f;



#pragma mark -- lifeCircle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.view.frame = frame;
        self.width = frame.size.width;
        self.height = frame.size.height;
    }
    return self;
}

+ (instancetype)bgSegementControllerWithFrame:(CGRect)frame {
    return [[BGSegementController alloc] initWithFrame:frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSInteger count = self.viewControllers.count;
    CGFloat itemsScrollerWidth = [[self.itemWidths valueForKeyPath:@"@sum.self"] floatValue] + (count+1)*itemMarginX;
    //1.itemsScrollerView
    self.itemsScrollerView.frame = CGRectMake(0, 0, self.width, self.tarBarHeight);
    self.itemsScrollerView.contentSize = CGSizeMake(itemsScrollerWidth, self.tarBarHeight);
    
    UIButton *lastBtn = nil;
    for (UIButton *btn in self.itemViews) {
        NSInteger index = btn.tag - btnnPrefix;
        CGFloat btnX = ((lastBtn==nil) ? itemMarginX : (CGRectGetMaxX(lastBtn.frame) + itemMarginX));
        CGFloat btnW = [self.itemWidths[index] floatValue];
        CGFloat btnH = self.tarBarHeight;
        btn.frame = CGRectMake(btnX, 0.f, btnW, btnH);
        lastBtn = btn;
    }
    
    //2.viewsScrollerView
    self.viewsScrollerView.frame = CGRectMake(0, self.tarBarHeight, self.width, self.height-self.tarBarHeight);
    self.viewsScrollerView.contentSize = CGSizeMake(count*self.width, self.height-self.tarBarHeight);
    
    for (UIView *view in self.controllerViews) {
        NSInteger index = view.tag - viewPrefix;
        CGFloat viewX = index * self.width;
        CGFloat viewW = self.width;
        CGFloat viewH = self.height - self.tarBarHeight;
        view.frame = CGRectMake(viewX, 0.f, viewW, viewH);
    }
    
    CGFloat indicateW = [self.itemWidths[0] floatValue];
    self.indicateView.frame = CGRectMake(0, self.tarBarHeight-3, indicateW, 3);
    
    [self.itemsScrollerView bringSubviewToFront:self.indicateView];
    [self didClickButton:self.itemViews[0]];
}

#pragma mark -- 1.start
//1.start
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    if (_viewControllers != viewControllers) {
        _viewControllers = viewControllers;
        [self configerItemsScrollerView];
        [self configerViewsScrollerView];
    }
}

#pragma mark -- 2.event response
- (void)didClickButton:(UIButton *)btn
{
    self.viewsScrollerView.userInteractionEnabled = NO;
    if (btn != self.previosBtn) {
        btn.selected = YES;
        _previosBtn.selected = !_previosBtn.isSelected;
        _previosBtn = btn;
        [self scrollIndicateView];
        [self scrollSegementView];
    }
    self.viewsScrollerView.userInteractionEnabled = YES;
}

#pragma mark -- 3.SystemDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = round(scrollView.contentOffset.x / self.width);
    [self setSelectedItemAtIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger tempIndext = self.previosBtn.tag - btnnPrefix;
    NSInteger currentIndex = tempIndext;
    
    // 当当前的偏移量大于被选中index的偏移量的时候，就是在右侧
    CGFloat offset; // 在同一侧的偏移量
    NSInteger buttonIndex = currentIndex;
    if (offsetX >= tempIndext *self.width) {
        offset = offsetX - tempIndext *self.width;
        buttonIndex += 1;
    } else {
        offset = tempIndext *self.width - offsetX;
        buttonIndex -= 1;
        currentIndex -= 1;
    }
    
    CGFloat originMovedX = CGRectGetMinX(self.previosBtn.frame);
    CGFloat targetMovedWidth = [self widthAtIndex:currentIndex];//需要移动的距离
    CGFloat targetButtonWidth = [self widthAtIndex:buttonIndex]; // 这个会影响width
    CGFloat originButtonWidth = [self widthAtIndex:tempIndext];
    
    
    CGFloat moved; // 移动的距离
    moved = offsetX - tempIndext *self.width;
    _indicateView.frame = CGRectMake(originMovedX + targetMovedWidth /self.width * moved, _indicateView.frame.origin.y,  originButtonWidth + (targetButtonWidth - originButtonWidth) /self.width * offset, _indicateView.frame.size.height);
}

#pragma mark -- 4.public methods

#pragma mark -- private methods
//初始化itemScroller及subview
- (void)configerItemsScrollerView {
    NSAssert(_viewControllers.count>0, @"_viewControllers不能为空");
    NSMutableArray *tempA = [NSMutableArray arrayWithCapacity:(_viewControllers.count)];
    NSMutableArray *tempB = [NSMutableArray arrayWithCapacity:(_viewControllers.count)];
    NSMutableArray *tempC = [NSMutableArray arrayWithCapacity:(_viewControllers.count)];
    NSInteger count = _viewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *viewController = (UIViewController *)_viewControllers[i];
        NSString *title = [self nullToString:viewController.title];
        NSAssert(![title isEqualToString:@""], @"viewController.title有为空的(nil)或为空格");
        [tempA addObject:title];
        
        UIButton *btn = [self getOneButtonWithTitle:title];
        btn.tag = i + btnnPrefix;
        [self.itemsScrollerView addSubview:btn];
        [tempB addObject:btn];
        
        CGFloat titleW = [title sizeWithAttributes:@{NSFontAttributeName:self.itemFone}].width;
        [tempC addObject:@(titleW)];
    }
    self.itemTitles = [tempA copy];
    self.itemViews  = [tempB copy];
    self.itemWidths = [tempC copy];
}

//初始化viewsScroller及subview
- (void)configerViewsScrollerView {
    NSAssert(_viewControllers.count>0, @"_viewControllers不能为空");
    NSMutableArray *tempA = [NSMutableArray arrayWithCapacity:(_viewControllers.count)];
    NSInteger count = _viewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *viewController = (UIViewController *)_viewControllers[i];
        UIView *view = (UIView *)viewController.view;
        view.tag = i + viewPrefix;
        [tempA addObject:view];
        [viewController willMoveToParentViewController:self];
        [self.viewsScrollerView addSubview:view];
        [viewController didMoveToParentViewController:self];
        [self addChildViewController:viewController];
    }
    self.controllerViews = [tempA copy];
}

//同步IndicateView
- (void)scrollIndicateView
{
    NSInteger index = self.previosBtn.tag - btnnPrefix;
    CGFloat titleW = [self.itemWidths[index] floatValue];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.indicateView.frame = CGRectMake(CGRectGetMinX(self.previosBtn.frame), CGRectGetMinY(self.indicateView.frame), titleW, CGRectGetHeight(self.indicateView.bounds));
        [self.viewsScrollerView setContentOffset:CGPointMake(index*self.width, 0)];
    }completion:nil];
}

//同步segementView的offset
- (void)scrollSegementView
{
    NSInteger index = self.previosBtn.tag - btnnPrefix;
    CGFloat titleW = [self.itemWidths[index] floatValue];
    CGFloat viewW = self.width;
    CGFloat offsetX = (viewW - titleW) * 0.5f;
    
    if (self.previosBtn.frame.origin.x <= viewW * 0.5f) {
        [_itemsScrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (CGRectGetMaxX(self.previosBtn.frame) >= (_itemsScrollerView.contentSize.width - viewW * 0.5f)) {
        [_itemsScrollerView setContentOffset:CGPointMake(_itemsScrollerView.contentSize.width - viewW, 0) animated:YES];
    } else {
        [_itemsScrollerView setContentOffset:CGPointMake(CGRectGetMinX(self.previosBtn.frame) - offsetX, 0) animated:YES];
    }
}

//选中index位置的item
- (void)setSelectedItemAtIndex:(NSInteger)index {
    for (UIButton *btn in self.itemViews) {
        if (index == btn.tag-btnnPrefix ) {
            [self didClickButton:btn];
            return;
        }
    }
}

//计算,获取index位置btn的宽度
- (CGFloat)widthAtIndex:(NSInteger)index {
    if (index < 0 || index > self.viewControllers.count - 1) {
        return .0;
    }
    return [[self.itemWidths objectAtIndex:index] floatValue];
}

#pragma mark -- setter
- (void)setColor:(UIColor *)color forState:(UIControlState)state {
    if (UIControlStateNormal == state) {
        self.normalColor = color;
    } else if (UIControlStateSelected == state){
        self.selectedColor = color;
    } else {
        self.normalColor = color;
    }
}

#pragma mark -- getter
- (UIScrollView *)itemsScrollerView {
    if (_itemsScrollerView == nil) {
        _itemsScrollerView = [[UIScrollView alloc] init];
        _itemsScrollerView.backgroundColor = [UIColor whiteColor];
//        _itemsScrollerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _itemsScrollerView.showsHorizontalScrollIndicator = NO;
        _itemsScrollerView.showsVerticalScrollIndicator   = NO;
        _itemsScrollerView.bounces   = NO;
        [self.view addSubview:_itemsScrollerView];
        //        _itemsScrollerView.backgroundColor = [UIColor yellowColor];
    }
    return _itemsScrollerView;
}

- (UIScrollView *)viewsScrollerView {
    if (_viewsScrollerView == nil) {
        _viewsScrollerView = [[UIScrollView alloc] init];
//        _viewsScrollerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _viewsScrollerView.showsHorizontalScrollIndicator = NO;
        _viewsScrollerView.showsVerticalScrollIndicator   = NO;
        _viewsScrollerView.pagingEnabled = YES;
        _viewsScrollerView.delegate = self;
        _viewsScrollerView.bounces   = NO;

        [self.view addSubview:_viewsScrollerView];
    }
    return _viewsScrollerView;
}

- (BGIndicateView *)indicateView {
    if (_indicateView == nil) {
        _indicateView = [[BGIndicateView alloc] init];
        _indicateView.color = [UIColor greenColor];
        [self.itemsScrollerView addSubview:_indicateView];
    }
    return _indicateView;
}

- (CGFloat)tarBarHeight {
    return _tarBarHeight ? : 44.f;
}

- (UIButton *)getOneButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
    btn.titleLabel.font = self.itemFone;
    [btn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIColor *)normalColor {
    return _normalColor =  (_normalColor) ? : [UIColor lightGrayColor];
}

- (UIColor *)selectedColor {
    return _selectedColor =  (_selectedColor) ? : [UIColor redColor];
}

- (UIFont *)itemFone {
    return _itemFone ? : [UIFont systemFontOfSize:14.f];
}

#pragma mark -- other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)nullToString:(id)sender {
    if (sender == [NSNull null]){ return @"";}
    
    if (![sender isKindOfClass:[NSString class]])
    {
        sender = [sender stringValue];
    }
    
    if (sender == [NSNull null] ||
        [sender isKindOfClass:[NSNull class]]||
        sender == nil||
        [sender isEqualToString:@"(null)"]||
        [sender isEqualToString:@"<null>"]||
        [sender isEqualToString:@" "]||
        sender == [NSNull null] ) {
        return @"";
    } else {
        return sender;
    }
}

@end



