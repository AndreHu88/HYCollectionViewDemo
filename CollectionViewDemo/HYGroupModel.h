//
//  HYGroupModel.h
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYItemModel.h"

@interface HYGroupModel : NSObject

/**type*/
@property (nonatomic,copy) NSString *type;

@property (nonatomic,strong) NSMutableArray *itemsArray;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end
