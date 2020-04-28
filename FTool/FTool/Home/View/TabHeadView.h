//
//  TabHeadView.h
//  Life
//
//  Created by jie.huang on 31/3/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TabHeadView : UIView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *BannerView;

@property (nonatomic,strong) NSArray *urlArr;
@property (nonatomic,strong) NSArray *TitleArr;

@end

NS_ASSUME_NONNULL_END
