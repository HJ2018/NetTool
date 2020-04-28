//
//  CellCollectionView.m
//  Life
//
//  Created by jie.huang on 5/4/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "CellCollectionView.h"
#import "MoreCollectionCell.h"
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

static NSString *const collectioncellID = @"collectioncellID";

@interface CellCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CellCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenW - 20, (ScreenW-80)/4 + 40);
        [self addSubview:self.collectionView];
    }
    return self;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW - 20, (ScreenW-80)/4 + 40) collectionViewLayout:flowLayout];
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake((ScreenW-80)/4, (ScreenW-80)/4 + 40);
        
        flowLayout.minimumLineSpacing = 20;

        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MoreCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:collectioncellID];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectioncellID forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"---点击了第%ld个控件",(long)indexPath.row);
}

@end
