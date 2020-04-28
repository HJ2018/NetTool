//
//  HomeCell.m
//  Life
//
//  Created by jie.huang on 31/3/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "HomeCell.h"
#import "DataModel.h"
@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)setModel:(DataModel *)model{
    
    _model = model;
    
//    self.Contenlable.text = model.Name;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 10;
    frame.origin.y = frame.origin.y + 10;
    
    [super setFrame:frame];
}



@end
