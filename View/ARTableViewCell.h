//
//  ARTableViewCell.h
//  YouDian_AR
//
//  Created by youdian on 2018/5/25.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTableViewCell : UITableViewCell

@property (strong, nonatomic)UIImageView *proImgView;
@property (strong, nonatomic)UILabel *label;
@end

@interface SetTableViewCell : UITableViewCell


@property (strong, nonatomic)UILabel *funLabel;
@property (strong, nonatomic)UIView *subView;
@end
