//
//  RunBaseResponse.m
//  JRun
//
//  Created by jie.huang on 12/7/2019.
//  Copyright © 2019 zhengding. All rights reserved.
//

#import "RunBaseResponse.h"
@implementation RunBaseResponse

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n状态吗: %zd,\n错误: %@,\n响应头: %@,\n响应体: %@", self.statusCode, self.error, self.headers, self.responseObject];
}

- (void)setError:(NSError *)error {
    _error = error;
    self.statusCode = error.code;
    self.errorMsg = error.localizedDescription;
}

@end
