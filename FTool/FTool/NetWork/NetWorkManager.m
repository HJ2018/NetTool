//
//  NetWorkManager.m
//  FTool
//
//  Created by jie.huang on 26/4/2020.
//  Copyright © 2020 jie.huang. All rights reserved.
//

#import "NetWorkManager.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "NSObject+MJParse.h"
#import "ModelStr.h"

#define RUNIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

@interface NetWorkManager ()

@property (nonatomic,strong) AFURLSessionManager *Bodymanager;

@end

@implementation NetWorkManager


static NetWorkManager *instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


-(void)hudShow{
        
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
    hud.defaultMotionEffectsEnabled = NO;
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
}

-(void)hudHide{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    [MBProgressHUD hideHUDForView:window animated:YES];
}

- (void)setValue:(NSString *)value forHttpField:(NSString *)field {
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

-(AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableSet *setM = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"text/html"];
        _sessionManager.requestSerializer.timeoutInterval = 30;
        _sessionManager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionManager;
}

-(AFURLSessionManager *)Bodymanager{
    
    if (!_Bodymanager) {
     
        _Bodymanager = [AFURLSessionManager new];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript", @"text/plain",nil];
        _Bodymanager.responseSerializer = responseSerializer;
        
    }
    return _Bodymanager;
}


-(void)request:(RequestType)requestType requestSerializerType:(RequestSerializerType)requestSerializerType
        urlStr:(NSString *)urlStr
     parameter:(NSDictionary *)param
   withHUDShow:(BOOL)withHUDShow
   withHUDHide:(BOOL)withHUDHide
         model:(Class)modelClass
   resultBlock:(void (^)(RunBaseResponse *))resultBlock{
    
    if (withHUDShow) {
        [self hudShow];
    }
    
    NSMutableString *finalUrl = [[NSMutableString alloc] initWithString:@""];
    [finalUrl appendString:urlStr];
    
    switch (requestSerializerType) {
        case ERequestSerializerTypeHTTP:
        {
            self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        case ERequestSerializerTypeJSON:
        {
            self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [self.sessionManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            break;
        }case ERequestFormUrlencoded:{
            break;
        }
        default:
            break;
    }
    
    if (self.sessionManager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        RunBaseResponse *response = [RunBaseResponse new];
        response.error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
        response.errorMsg = @"网络无法连接";
        resultBlock(response);
        return;
    }
    
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self wrapperTask:task model:(Class)modelClass responseObject:responseObject error:nil completion:resultBlock];
        if (withHUDHide) {
           [self hudHide];
        }
    };
    
    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self wrapperTask:task model:(Class)modelClass responseObject:nil error:error completion:resultBlock];
        if (withHUDHide) {
            [self hudHide];
        }
    };
    
    if (requestType == RequestTypeGet) {
        [self.sessionManager GET:finalUrl parameters:param progress:nil success:successBlock failure:failBlock];
    }else {
        [self.sessionManager POST:finalUrl parameters:param progress:nil success:successBlock failure:failBlock];
    }
}

-(void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param withHUDShow:(BOOL)withHUDShow withHUDHide:(BOOL)withHUDHide success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    if (withHUDShow) {
        [self hudShow];
    }
    
    NSMutableString *finalUrl = [[NSMutableString alloc] initWithString:@""];
    [finalUrl appendString:urlStr];
    
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        if (withHUDHide) {
            [self hudHide];
        }
    };
    
    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
        if (withHUDHide) {
            [self hudHide];
        }
    };
    
    if (requestType == RequestTypeGet) {
        
        [self.sessionManager GET:finalUrl parameters:param progress:nil success:successBlock failure:failBlock];
    }else {
        [self.sessionManager POST:finalUrl parameters:param progress:nil success:successBlock failure:failBlock];
    }
    
}



- (void)upload:(NSString *)urlString
    parameters:(id)parameters
   withHUDShow:(BOOL)withHUDShow
   withHUDHide:(BOOL)withHUDHide
         model:(Class)modelClass
 formDataBlock:(NSDictionary<NSData *, DataName *> *(^)(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *, DataName *> *needFillDataDict))formDataBlock
      progress:(void (^)(NSProgress *progress))progress
    completion:(void (^)(RunBaseResponse *response))completion
{
    
    if (withHUDShow) {
        [self hudShow];
    }
    NSMutableString *finalUrl = [[NSMutableString alloc] initWithString:@""];
    [finalUrl appendString:urlString];
    static NSString *mineType = @"application/octet-stream";
    
    [self.sessionManager POST:finalUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSMutableDictionary *needFillDataDict = [NSMutableDictionary dictionary];
        NSDictionary *datas = !formDataBlock ? nil : formDataBlock(formData, needFillDataDict);
        
        if (datas) {
            [datas enumerateKeysAndObjectsUsingBlock:^(NSData * _Nonnull data, DataName * _Nonnull name, BOOL * _Nonnull stop) {
                [formData appendPartWithFileData:data name:name fileName:@"random" mimeType:mineType];
            }];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            !progress ?: progress(uploadProgress);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (withHUDHide) {
           [self hudHide];
        }
        [self wrapperTask:task model:modelClass responseObject:responseObject error:nil completion:completion];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (withHUDHide) {
            [self hudHide];
        }
        [self wrapperTask:task model:modelClass responseObject:nil error:error completion:completion];
    }];
}

-(void)postWithUrl:(NSString *)url
              body:(NSDictionary *)body
       withHUDShow:(BOOL)withHUDShow
       withHUDHide:(BOOL)withHUDHide
             model:(Class)modelClass
       resultBlock:(void (^)(RunBaseResponse * _Nonnull))resultBlock
{
    
    if (withHUDShow) {
        [self hudShow];
    }
    NSData *dataBody =[NSJSONSerialization dataWithJSONObject:body options:NSUTF8StringEncoding error:nil];

    NSMutableString *requestUrl = [[NSMutableString alloc] initWithString:@""];
    [requestUrl appendString:url];
    
    //如果你不需要将通过body传 那就参数放入parameters里面
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    
    NSLog(@"requestURL:%@",requestUrl);
    
    request.timeoutInterval= 30;
    
    // 设置body 在这里将参数放入到body
    [request setHTTPBody:dataBody];

    [[self.Bodymanager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
        
        if(responseObject!=nil){
            
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if (withHUDHide) {
                [self hudHide];
            }
             [self wrapperTask:nil model:(Class)modelClass responseObject:resultDic error:nil completion:resultBlock];
        }
        
        if (error) {
            
            if (withHUDHide) {
                [self hudHide];
            }
             [self wrapperTask:nil model:(Class)modelClass responseObject:nil error:error completion:resultBlock];
        }
        
    }]resume];
    
}

#pragma mark - 处理数据
- (void)wrapperTask:(NSURLSessionDataTask *)task model:(Class)modelClass responseObject:(id)responseObject error:(NSError *)error completion:(void (^)(RunBaseResponse *response))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        RunBaseResponse *response = [self convertTask:task model:(Class)modelClass responseObject:responseObject error:error];
        
        [self LogResponse:task.currentRequest.URL.absoluteString response:response model:modelClass];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !completion ?: completion(response);
        });
    });
}

#pragma mark - 打印返回日志
- (void)LogResponse:(NSString *)urlString response:(RunBaseResponse *)response model:(Class)modelClass
{
    NSLog(@"\n[%@]---%@\n", urlString, response);
//     NSStringFromClass([STImageViewclass])

    NSLog(@"%@",[[ModelStr sharedInstance] CareModel:NSStringFromClass(modelClass) Datajson:response.responseObject fixName:@"HJ"]);

    if (response.error) {
         dispatch_async(dispatch_get_main_queue(), ^{
            [self hudHide];
//            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            [MBProgressHUD showMessage:response.errorMsg ToView:delegate.window RemainTime:1.0];
        });
    }
 
}


#pragma mark - 包装返回的数据
- (RunBaseResponse *)convertTask:(NSURLSessionDataTask *)task model:(Class)modelClass responseObject:(id)responseObject error:(NSError *)error
{
    
    RunBaseResponse *response = [RunBaseResponse new];
    
    if (!RUNIsEmpty(responseObject)) {
        response.responseObject = responseObject;
    }
    if (!RUNIsEmpty(responseObject) && !RUNIsEmpty(modelClass)) {
        response.classModel = [modelClass MTMJParse:responseObject];
    }
    if (error) {
        response.error = error;
    }
    
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *HTTPURLResponse = (NSHTTPURLResponse *)task.response;
        response.headers = HTTPURLResponse.allHeaderFields.mutableCopy;
    }
    
    if (self.responseFormat) {
        response = self.responseFormat(response);
    }
    
    return response;
}

- (void)setCerFilePath:(NSString *)cerFilePath {
    _cerFilePath = cerFilePath;
    if (RUNIsEmpty(cerFilePath)) {
        return;
    }
    NSData *cerData = [NSData dataWithContentsOfFile:cerFilePath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    [self.sessionManager setSecurityPolicy:securityPolicy];
}

@end
