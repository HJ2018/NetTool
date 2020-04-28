//
//  TableViewModel.m
//  MAIHealth
//
//  Created by jie.huang on 26/2/19.
//  Copyright © 2019年 MAITIAN. All rights reserved.
//

#import "TableViewModel.h"
#import "DataModel.h"
#import "NetWorkManager.h"
#import "NSObject+MJParse.h"
#import "ModelStr.h"

@interface TableViewModel()

@property (nonatomic, strong) NSMutableArray<DataModel *> *ContentData;
@property (nonatomic, strong) NSMutableArray *BannerArry;


@end

@implementation TableViewModel



- (void)TableViewData:(callback)callback headBanner:(headBack)headBack{
 
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
    [queryParams setObject:@"dev" forKey:@"home"];
    
    [[NetWorkManager sharedInstance] request:RequestTypePost requestSerializerType:ERequestSerializerTypeHTTP urlStr:@"Home" parameter:queryParams withHUDShow:YES withHUDHide:YES model:DataModel.class resultBlock:^(RunBaseResponse * _Nonnull response) {
        
        self.ContentData = [DataModel MTMJParse:response.responseObject[@"Tab"]];
        self.BannerArry = response.responseObject[@"banner"];
        callback(self.ContentData);
        headBack(self.BannerArry , response.responseObject[@"bannerTitle"]);
        
    }];
    
}

@end
