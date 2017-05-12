//
//  HYHeaderView.m
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHeaderView.h"

@implementation HYHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width - 100, 30)];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_titleLabel];

    }
    return self;
}

@end
