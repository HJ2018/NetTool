//
//  Stubs.m
//  Life
//
//  Created by jie.huang on 28/3/19.
//  Copyright © 2019年 jie.huang. All rights reserved.
//

#import "Stubs.h"
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"

// Mock Loading Duration
#define REQUEST_TIME                    1.0

@implementation Stubs

static id<OHHTTPStubsDescriptor> HomeStub = nil;

+ (void)installStubs
{
    [self installHomeStub];
}

+ (void)installHomeStub
{
    HomeStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        
        NSRange range = [[request.URL absoluteString] rangeOfString:@"Home"];
        
        return range.location != NSNotFound;
        
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"Home.json", self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}]
                requestTime:REQUEST_TIME
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
    
    HomeStub.name = @"HomeStub";
}

+ (void)removeStubs
{
    [OHHTTPStubs removeAllStubs];
}

@end
