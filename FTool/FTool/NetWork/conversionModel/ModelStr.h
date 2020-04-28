//
//  ModelStr.h
//  FTool
//
//  Created by jie.huang on 26/4/2020.
//  Copyright © 2020 jie.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModelStr : NSObject


+ (instancetype)sharedInstance;

-(NSString *)CareModel:(NSString *)ModelName Datajson:(NSDictionary *)dict fixName:(NSString *)fixName;

@end

NS_ASSUME_NONNULL_END
