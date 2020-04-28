//
//  RunBaseResponse.h
//  JRun
//
//  Created by jie.huang on 12/7/2019.
//  Copyright © 2019 zhengding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunBaseResponse : NSObject


/** 错误 */
@property (nonatomic, strong) NSError *error;

/** 错误提示 */
@property (nonatomic, copy) NSString *errorMsg;

/** 错误码 */
@property (assign, nonatomic) NSInteger statusCode;

/** 响应头 */
@property (nonatomic, strong) NSMutableDictionary *headers;

/** 响应体 */
@property (nonatomic, strong) id responseObject;

/** 响应体Model */
@property (nonatomic, strong) Class classModel;




@end

NS_ASSUME_NONNULL_END
