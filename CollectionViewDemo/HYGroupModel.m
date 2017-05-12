
//
//  HYGroupModel.m
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGroupModel.h"
#import "HYItemModel.h"

@implementation HYGroupModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        self.type = [dict objectForKey:@"type"];
        _itemsArray = [NSMutableArray array];
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *dic in [dict objectForKey:@"items"]) {
            
            HYItemModel *model = [[HYItemModel alloc] initWithDict:dic];
            [tmpArray addObject:model];
        }
        self.itemsArray = tmpArray;
    }
    return self;
}

@end
