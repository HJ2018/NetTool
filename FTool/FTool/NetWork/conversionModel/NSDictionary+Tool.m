//
//  NSDictionary+Tool.m
//  Run
//
//  Created by jie.huang on 20/1/2020.
//  Copyright © 2020 microcrystal. All rights reserved.
//

#import "NSDictionary+Tool.h"

@implementation NSDictionary (Tool)


- (NSString *)toString
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
