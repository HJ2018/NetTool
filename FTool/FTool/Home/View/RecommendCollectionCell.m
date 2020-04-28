//
//  RecommendCollectionCell.m
//  Life
//
//  Created by jie.huang on 5/4/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "RecommendCollectionCell.h"

@implementation RecommendCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconIamgeView.layer.cornerRadius = 5;
    self.iconIamgeView.layer.masksToBounds = YES;
}

@end
