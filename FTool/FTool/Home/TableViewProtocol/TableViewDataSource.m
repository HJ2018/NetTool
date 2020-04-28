//
//  TableViewDataSource.m
//  MAIHealth
//
//  Created by jie.huang on 26/2/19.
//  Copyright © 2019年 MAITIAN. All rights reserved.
//

#import "TableViewDataSource.h"
#import "HomeCell.h"
#import "CellCollectionView.h"
#import "RecommendView.h"
#import "UIView+Extended.h"

static NSString * const HomeID = @"HomeID";

@interface TableViewDataSource ()

@property(nonatomic ,strong)CellCollectionView *Oneview;

@property(nonatomic ,strong)RecommendView *TwoView;

@end

@implementation TableViewDataSource


-(CellCollectionView *)Oneview{
    
    if (_Oneview == nil) {
        
        _Oneview = [[CellCollectionView alloc]init];
    }
    return _Oneview;
}
- (RecommendView *)TwoView{
    
    if (_TwoView == nil) {
        
        _TwoView = [RecommendView viewFromxib];
    }
    return _TwoView;
}


+(void)registerClass:(UITableView *)table{
    
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellReuseIdentifier:HomeID];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.DataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeID];
    
    cell.model = self.DataArr[indexPath.row];
    if (indexPath.row == 0) {
        self.Oneview.hidden = NO;
        [cell.contentView addSubview:self.Oneview];
    }else if (indexPath.row == 1){
        self.TwoView.hidden = NO;
        [cell.contentView addSubview:self.TwoView];
    }else{
        cell.iconImageView.hidden =NO;
        cell.playBtn.hidden =NO;
        cell.TitleLabel.hidden = NO;
        cell.ContentLabel.hidden =NO;
    }
    
    return cell;
}



@end
