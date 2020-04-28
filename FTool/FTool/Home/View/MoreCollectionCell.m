//
//  MoreCollectionCell.m
//  Life
//
//  Created by jie.huang on 4/4/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "MoreCollectionCell.h"
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

@implementation MoreCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.iconImageView.layer.cornerRadius = (((ScreenW-80)/4)-20)/2;
    self.iconImageView.layer.masksToBounds = YES;
}


@end
