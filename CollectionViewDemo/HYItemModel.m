//
//  HYItemModel.m
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYItemModel.h"

@implementation HYItemModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.titleStr = dict[@"itemTitle"];
        self.iconStr = dict[@"imageName"];
    }
    return self;
}

@end
