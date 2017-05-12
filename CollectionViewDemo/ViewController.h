//
//  ViewController.h
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/** 是否编辑*/
@property (nonatomic,assign) BOOL isEditing;

/** 动画View */
@property (nonatomic,strong) UIView *snapShotView;

@end

