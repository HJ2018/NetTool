//
//  TableViewDelegate.h
//  MAIHealth
//
//  Created by jie.huang on 26/2/19.
//  Copyright © 2019年 MAITIAN. All rights reserved.
//

#import "DataModel.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic,strong) NSArray<DataModel *> *DataArr;

@end
