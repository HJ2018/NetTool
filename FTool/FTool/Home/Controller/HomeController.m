//
//  HomeController.m
//  Life
//
//  Created by jie.huang on 27/3/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "HomeController.h"
#import "TableViewDataSource.h"
#import "TableViewDelegate.h"
#import "TableViewModel.h"
#import "ModelStr.h"
#import "SDCycleScrollView.h"
#import "TabHeadView.h"
#import "UIView+Extended.h"


#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define WEAKSELF typeof(self) __weak weakSelf = self;

#define HJGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HJGlobalBg HJRGBColor(223, 223, 223)


#define HJColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define HJColor(r, g, b) HJColorA((r), (g), (b), 255)
#define HJRandomColor HJColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define HJrayColor(v) HJColor((v), (v), (v))


@interface HomeController ()

@property (nonatomic, strong) TableViewDataSource *TabDataSource;

@property (nonatomic, strong) TableViewDelegate *TabDelegate;

@property (nonatomic, strong) TableViewModel *DataModel;

@property (nonatomic, strong) TabHeadView *TabHeadView;

@end

@implementation HomeController

-(TableViewDataSource *)TabDataSource{
    if (!_TabDataSource) {
        _TabDataSource = [TableViewDataSource new];
        self.tableView.dataSource = _TabDataSource;
    }
    return _TabDataSource;
}

-(TableViewDelegate *)TabDelegate{
    if (!_TabDelegate) {
        _TabDelegate = [TableViewDelegate new];
        self.tableView.delegate = _TabDelegate;
    }
    return _TabDelegate;
}

-(TableViewModel *)DataModel{
    if (!_DataModel) {
        
        _DataModel = [TableViewModel new];
    }
    return _DataModel;
}

-(TabHeadView *)TabHeadView{
    
    if (!_TabHeadView) {
        
        _TabHeadView = [TabHeadView viewFromxib];
        _TabHeadView.layer.cornerRadius = 5;
        _TabHeadView.layer.masksToBounds = YES;
    }
    return _TabHeadView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = HJColor(247, 247, 247);
    self.view.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [UIView new];
    [TableViewDataSource  registerClass:self.tableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableHeaderView = self.TabHeadView;
    
    [self loadData];
}

-(void)loadData{
    WEAKSELF
    [self.DataModel TableViewData:^(NSMutableArray<DataModel *> *Contentarry) {
        weakSelf.TabDataSource.DataArr = Contentarry;
        weakSelf.TabDelegate.DataArr = Contentarry;
        [weakSelf.tableView reloadData];
    } headBanner:^(NSArray *bannerArry, NSArray *titlearry) {
        weakSelf.TabHeadView.TitleArr = titlearry;
        weakSelf.TabHeadView.urlArr = bannerArry;
    }];
}




@end
