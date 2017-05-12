//
//  HYItemModel.h
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,Status) {

    StatusMinus = 1,        //减号
    StatusPlus,             //加号
    StatusCheck,            //对勾
    
};

@interface HYItemModel : NSObject

/** */
@property (nonatomic,strong) NSString *titleStr;
/** 图片名 */
@property (nonatomic,strong) NSString *iconStr;
/** 状态 */
@property (nonatomic,assign) Status status;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
