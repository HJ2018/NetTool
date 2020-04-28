//
//  TableViewModel.h
//  MAIHealth
//
//  Created by jie.huang on 26/2/19.
//  Copyright © 2019年 MAITIAN. All rights reserved.
//

#import "DataModel.h"

typedef void (^callback) (NSMutableArray<DataModel *> *Contentarry);

typedef void (^headBack) (NSArray *bannerArry ,NSArray *titlearry);

@interface TableViewModel : NSObject

- (void)TableViewData:(callback)callback headBanner:(headBack)headBack;

@end
