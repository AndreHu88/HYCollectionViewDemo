//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by leimo on 2017/5/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "HYCustomCollectionViewCell.h"
#import "HYGroupModel.h"
#import "HYHeaderView.h"

static NSString *cellID = @"HYCustomCellID";
static NSString *reuseableID = @"sectionHeader";

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,HYCellDelegate>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSoucre*/
@property (nonatomic,strong) NSMutableArray *dataSource;

/**要移动的indexPath*/
@property (nonatomic,strong) NSIndexPath *moveIndexPath;
/**当前的indexPath*/
@property (nonatomic,strong) NSIndexPath *originallyIndexPath;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth / 4, kScreenWidth / 4);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 50);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //注册cell
        [_collectionView registerClass:[HYCustomCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        //注册header
        [_collectionView registerClass:[HYHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseableID];
        
        _collectionView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_collectionView addGestureRecognizer:longPress];
    }

    return _collectionView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSArray *array = @[@{
                               @"type" : @"首页快捷入口",
                               @"items" :[NSMutableArray array]
                               },@{
                               @"type" : @"我的",
                               @"items" : @[
                                       @{@"imageName" : @"我的订阅",
                                         @"itemTitle" : @"我的订阅"},
                                       @{@"imageName" : @"球爆",
                                         @"itemTitle" : @"球爆"},]
                               },
                           @{
                               @"type" : @"基础服务",
                               @"items" : @[@{@"imageName" : @"名人名单",@"itemTitle" : @"名人名单"},
                                            @{@"imageName" : @"竞彩足球",@"itemTitle" : @"竞彩足球"},
                                            @{@"imageName" : @"竞彩篮球",@"itemTitle" : @"竞彩篮球"},
                                            @{@"imageName" : @"足彩",@"itemTitle" : @"足彩"},]
                               },
                           @{
                               @"type" : @"发现新鲜事",
                               @"items" : @[@{@"imageName" : @"爆单",@"itemTitle" : @"爆单"},
                                            @{@"imageName" : @"专业分析",@"itemTitle" : @"专业分析"},
                                            @{@"imageName" : @"最新话题",@"itemTitle" : @"最新话题"},
                                            @{@"imageName" : @"热门话题",@"itemTitle" : @"热门话题"},]
                               },
                           @{
                               @"type":@"新闻资讯",
                               @"items" : @[@{@"imageName" : @"热点资讯",@"itemTitle" : @"热点资讯"},
                                            @{@"imageName" : @"我不是头条",@"itemTitle" : @"我不是头条"},
                                            @{@"imageName" : @"名人专访",@"itemTitle" : @"名人专访"},
                                            @{@"imageName" : @"焦点赛事",@"itemTitle" : @"焦点赛事"},
                                            @{@"imageName" : @"活动专栏",@"itemTitle" : @"活动专栏"},]
                               },
                           ];
        
        _dataSource = [NSMutableArray array];
        NSMutableArray *temArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            HYGroupModel *group = [[HYGroupModel alloc] initWithDict:dict];
            if ([group.type isEqualToString:@"首页快捷入口"]) {
                for (HYItemModel *model in group.itemsArray) {
                    model.status = StatusMinus;
                }
            }
            [temArray addObject:group];
        }
        _dataSource = temArray;
    }
    
    
    
    return _dataSource;
}

- (void)setIsEditing:(BOOL)isEditing{

    _isEditing = isEditing;
    
}

#pragma mark ********collectionViewDelegate********
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HYCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    HYGroupModel *group = self.dataSource[indexPath.section];
    HYItemModel  *model = group.itemsArray[indexPath.row];
    cell.isEditing = _isEditing;
    
    if (indexPath.section != 0) {
        
        BOOL isAdd = NO;
        
        HYGroupModel *groupModel = self.dataSource[0];
        for (HYItemModel *item in groupModel.itemsArray) {
            //遍历第一个数组的model和其他的比对
            if ([item.titleStr isEqualToString:model.titleStr]) {
                
                isAdd = YES;
                break;
            }
        }
        
        if (isAdd) {
            model.status = StatusCheck;
        }
        else{
            model.status = StatusPlus;
        }
        
    }
    
    cell.delegate = self;
    cell.model = model;

    return cell;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    HYGroupModel *groupModel = self.dataSource[section];
    return groupModel.itemsArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HYHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseableID forIndexPath:indexPath];
        HYGroupModel *groupModel = self.dataSource[indexPath.section];
        headerView.titleLabel.text = groupModel.type;
        
        return headerView;

    }
    else
        return nil;
}

#pragma mark ********点击事件********
- (void)longPress:(UILongPressGestureRecognizer *)sender{

    CGPoint point = [sender locationInView:_collectionView];
    _moveIndexPath = [_collectionView indexPathForItemAtPoint:point];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"UIGestureRecognizerStateBegan");
        //展示右上角的btn
        if (_isEditing == NO) {
            
            _isEditing = YES;
            
            [self.collectionView reloadData];
        }
        
        if (_moveIndexPath.section == 0) {
            
            //选中的cell
            HYCustomCollectionViewCell *selectCell = (HYCustomCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:_moveIndexPath];
            
            //动画效果
            _snapShotView = [selectCell snapshotViewAfterScreenUpdates:YES];
            _snapShotView.frame = [selectCell convertRect:selectCell.bounds toView:self.view];
            [self.view addSubview:_snapShotView];
            
            _originallyIndexPath = [_collectionView indexPathForItemAtPoint:point];
            NSLog(@"------:%ld",(long)_originallyIndexPath.item);
            
            if (!_originallyIndexPath) {
                return;
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _snapShotView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                selectCell.hidden = YES;
            }];

            
        }
        
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
    
        _snapShotView.center = [sender locationInView:self.collectionView];
        
        if (_moveIndexPath.section == 0) {
            if (_moveIndexPath && ![_moveIndexPath isEqual:_originallyIndexPath]) {
                
                HYGroupModel *group = self.dataSource[0];
                NSInteger fromIndex = _originallyIndexPath.item;
                NSInteger toIndex = _moveIndexPath.item;
                if (fromIndex < toIndex) {
                    
                    [group.itemsArray exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
                }
                else{
                    [group.itemsArray exchangeObjectAtIndex:toIndex withObjectAtIndex:fromIndex];
                }
                
                [_collectionView moveItemAtIndexPath:_originallyIndexPath toIndexPath:_moveIndexPath];
                _originallyIndexPath = _moveIndexPath;
                
            }
            
        }
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        
        NSLog(@"UIGestureRecognizerStateEnded");
            
            //选中的cell
            HYCustomCollectionViewCell *selectCell = (HYCustomCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:_moveIndexPath];
            [_snapShotView removeFromSuperview];
            selectCell.hidden = NO;

    }
}

#pragma mark ********HYCellDelegate********
- (void)topRightButtonAction:(HYCustomCollectionViewCell *)cell{
    
    HYItemModel *model = cell.model;

    if (model.status == StatusMinus) {
        
        HYGroupModel *group = self.dataSource[0];
        [group.itemsArray removeObject:model];
        
        //动画效果
        UIView *snapShotView = [cell snapshotViewAfterScreenUpdates:YES];
        snapShotView.frame = [cell convertRect:cell.bounds toView:self.view];
        [self.view addSubview:snapShotView];
        
        cell.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            snapShotView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        } completion:^(BOOL finished) {
            
            [snapShotView removeFromSuperview];
            cell.hidden = NO;
            [self.collectionView reloadData];
        }];

    }
    else if (model.status == StatusPlus){
        
        NSLog(@"StatusPlus");
        model.status = StatusCheck;
        
        HYGroupModel *group = self.dataSource[0];
        HYItemModel *itemModel = [[HYItemModel alloc] init];
        itemModel.titleStr = model.titleStr;
        itemModel.iconStr = model.iconStr;
        itemModel.status = StatusMinus;
        [group.itemsArray addObject:itemModel];
        
        //动画效果
        UIView *snapShotView = [cell snapshotViewAfterScreenUpdates:YES];
        snapShotView.frame = [cell convertRect:cell.bounds toView:self.view];
        [self.view addSubview:snapShotView];
        
        cell.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            snapShotView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        } completion:^(BOOL finished) {
            
            [snapShotView removeFromSuperview];
            cell.hidden = NO;
            [self.collectionView reloadData];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
