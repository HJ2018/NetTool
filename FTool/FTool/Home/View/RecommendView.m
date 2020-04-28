//
//  RecommendView.m
//  Life
//
//  Created by jie.huang on 5/4/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "RecommendView.h"
#import "RecommendCollectionCell.h"
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define HJGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HJGlobalBg HJRGBColor(223, 223, 223)


#define HJColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define HJColor(r, g, b) HJColorA((r), (g), (b), 255)
#define HJRandomColor HJColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define HJrayColor(v) HJColor((v), (v), (v))
#define HJCommonBgColor HJrayColor(206)



static NSString *const RecommendID = @"RecommendID";
@interface RecommendView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation RecommendView

- (void)awakeFromNib{
    [super awakeFromNib];
    
     self.frame = CGRectMake(0, 0, ScreenW - 20, ((ScreenW-60)/3 + 55) * 2 + 45);
    [self settingCollection];
}


-(void)settingCollection{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.CollectionView setCollectionViewLayout:flowLayout];
    
    //定义每个UICollectionView 的大小
    flowLayout.itemSize = CGSizeMake((ScreenW-60)/3, (ScreenW-60)/3 + 40);
    //定义每个UICollectionView 横向的间距
    flowLayout.minimumLineSpacing = 15;
    //定义每个UICollectionView 纵向的间距
    flowLayout.minimumInteritemSpacing = 10;

    [self.CollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:RecommendID];
    
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    //自适应大小
    self.CollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecommendID forIndexPath:indexPath];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"---点击了第%ld个控件",(long)indexPath.row);
}


@end
