//
//  HYCustomCollectionViewCell.m
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCustomCollectionViewCell.h"

@interface HYCustomCollectionViewCell()

/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;

/** title */
@property (nonatomic,strong) UILabel *titleLabel;

/***/
@property (nonatomic,strong) UIButton *topRightbtn;

@end

@implementation HYCustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - 20, self.frame.size.height - 10)];
        _containerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _containerView.layer.borderWidth = 1;
        _containerView.backgroundColor = [UIColor whiteColor];
        
        [_containerView addSubview:self.iconImgView];
        [_containerView addSubview:self.titleLabel];
        [_containerView addSubview:self.topRightbtn];
        [self addSubview:_containerView];
    }
    return self;
}

#pragma mark ********懒加载********
- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake((_containerView.frame.size.width - 40) / 2, 18, 40, 40)];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 , _iconImgView.frame.origin.y + _iconImgView.frame.size.height + 10, _containerView.frame.size.width - 10, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

- (void)setModel:(HYItemModel *)model{
    
    _model = model;
    self.iconImgView.image = [UIImage imageNamed:model.iconStr];
    self.titleLabel.text = model.titleStr;
    switch (model.status) {
        case StatusPlus:
            
            [self.topRightbtn setImage:[UIImage imageNamed:@"图标_10"] forState:UIControlStateNormal];
            break;
        case StatusCheck:
            
            [self.topRightbtn setImage:[UIImage imageNamed:@"图标_08"] forState:UIControlStateNormal];
            break;
        case StatusMinus:
            
            [self.topRightbtn setImage:[UIImage imageNamed:@"图标_06"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}

- (UIButton *)topRightbtn{
    if (!_topRightbtn) {
        
        _topRightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = _containerView.frame.size.width - 40 / 2;
        _topRightbtn.frame = CGRectMake(x , 0 , 20, 20);
        [_topRightbtn addTarget:self action:@selector(topRightbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topRightbtn;
}

- (void)setIsEditing:(BOOL)isEditing{
    
    _topRightbtn.hidden = !isEditing;
    if (isEditing) {
        _containerView.layer.borderWidth = 0.4;
    }
    else{
        _containerView.layer.borderWidth = 0;
    }
}

- (void)topRightbtnClick:(UIButton *)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(topRightButtonAction:)]) {
        
        [_delegate topRightButtonAction:self];
    }

}

@end
