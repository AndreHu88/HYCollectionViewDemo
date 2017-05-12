//
//  HYCustomCollectionViewCell.h
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYItemModel.h"

@class HYCustomCollectionViewCell;

@protocol HYCellDelegate <NSObject>

- (void)topRightButtonAction:(HYCustomCollectionViewCell *)cell;

@end

@interface HYCustomCollectionViewCell : UICollectionViewCell

/***/
@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) UIView *containerView;

/** model */
@property (nonatomic,strong) HYItemModel *model;

/** 是否编辑*/
@property (nonatomic,assign) BOOL isEditing;

@property (nonatomic,weak)  id<HYCellDelegate>delegate;

@end
