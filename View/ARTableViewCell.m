//
//  ARTableViewCell.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/25.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "ARTableViewCell.h"

@implementation ARTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _proImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _proImgView.layer.borderWidth = 0.5f;
        _proImgView.layer.borderColor =[UIColor lightGrayColor].CGColor;
        [self addSubview: _proImgView];
        [_proImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 20, 0, 20));
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

@implementation SetTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _funLabel = [UILabel new];
        [self addSubview:_funLabel];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end






