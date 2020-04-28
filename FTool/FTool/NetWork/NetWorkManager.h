//
//  NetWorkManager.h
//  FTool
//
//  Created by jie.huang on 26/4/2020.
//  Copyright © 2020 jie.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunBaseResponse.h"
#import "AFNetworking.h"

typedef enum{
    RequestTypeGet,
    RequestTypePost
    
}RequestType;


typedef enum : NSInteger {
    LMJRequestManagerStatusCodeCustomDemo = -10000,
} LMJRequestManagerStatusCode;

typedef NS_ENUM (NSInteger, RequestSerializerType) {
    ERequestSerializerTypeHTTP = 0,
    ERequestSerializerTypeJSON,
    ERequestFormUrlencoded,
};

typedef NSString DataName;

typedef RunBaseResponse *_Nullable(^ResponseFormat)(RunBaseResponse *response);

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkManager : NSObject

@property (copy, nonatomic) ResponseFormat responseFormat;
@property (nonatomic, copy) NSString *cerFilePath;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

+(instancetype)sharedInstance;

- (void)hudShow;
- (void)hudHide;


- (void)request:(RequestType)requestType
requestSerializerType:(RequestSerializerType)requestSerializerType
         urlStr: (NSString *)urlStr
      parameter: (NSDictionary *)param
    withHUDShow:(BOOL)withHUDShow
    withHUDHide:(BOOL)withHUDHide
          model:(Class)modelClass
    resultBlock: (void(^)(RunBaseResponse *response))resultBlock;


- (void)request:(RequestType)requestType
         urlStr: (NSString *)urlStr
      parameter: (NSDictionary *)param
    withHUDShow:(BOOL)withHUDShow
    withHUDHide:(BOOL)withHUDHide
        success:(void(^)(id responseObj))success
        failure:(void(^)(NSError *error))failure;


- (void)upload:(NSString *)urlString
    parameters:(id)parameters
   withHUDShow:(BOOL)withHUDShow
   withHUDHide:(BOOL)withHUDHide
         model:(Class)modelClass
 formDataBlock:(NSDictionary<NSData *, DataName *> *(^)(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *, DataName *> *needFillDataDict))formDataBlock
      progress:(void (^)(NSProgress *progress))progress
    completion:(void (^)(RunBaseResponse *response))completion;


- (void)postWithUrl:(NSString *)url
               body:(NSDictionary *)body
        withHUDShow:(BOOL)withHUDShow
        withHUDHide:(BOOL)withHUDHide
              model:(Class)modelClass
        resultBlock: (void(^)(RunBaseResponse *response))resultBlock;

@end

NS_ASSUME_NONNULL_END
