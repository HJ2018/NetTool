//
//  TabHeadView.m
//  Life
//
//  Created by jie.huang on 31/3/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "TabHeadView.h"
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define HJGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HJGlobalBg HJRGBColor(223, 223, 223)


#define HJColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define HJColor(r, g, b) HJColorA((r), (g), (b), 255)
#define HJRandomColor HJColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define HJrayColor(v) HJColor((v), (v), (v))
#define HJCommonBgColor HJrayColor(206)


@interface TabHeadView ()<SDCycleScrollViewDelegate>

@end

@implementation TabHeadView


-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.backgroundColor = HJColor(247, 247, 247);
    self.frame = CGRectMake(0, 0, ScreenW, ScreenW * 0.486);
    self.BannerView.layer.cornerRadius = 5;
    self.BannerView.layer.masksToBounds = YES;
}


-(void)setUrlArr:(NSArray *)urlArr{
    
    _urlArr = urlArr;
    
    self.BannerView.delegate = self;
    self.BannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.BannerView.titlesGroup = self.TitleArr;
    self.BannerView.currentPageDotColor = [UIColor whiteColor];
    self.BannerView.imageURLStringsGroup = self.urlArr;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

@end
