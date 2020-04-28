//
//  ModelStr.m
//  FTool
//
//  Created by jie.huang on 26/4/2020.
//  Copyright © 2020 jie.huang. All rights reserved.
//

#import "ModelStr.h"
#import "XMLParser.h"
#import "NSDictionary+Tool.h"
#import <UIKit/UIKit.h>

#define DEFAULT_CLASS_NAME @("FTool")
#define kHJ_CLASS       @("\n@interface %@ :NSObject\n%@\n@end\n")

#define PROPERTY(s)    ((s) == 'c' ? @("@property (nonatomic , copy) %@              * %@;\n") : @("@property (nonatomic , strong) %@              * %@;\n"))
#define ASSIGN_PROPERTY    @("@property (nonatomic , assign) %@              %@;\n")


@interface ModelStr (){
    
    NSMutableString       *   _classString;        //存类头文件内容
    NSMutableString       *   _classMString;       //存类源文件内容
    NSString              *   _classPrefixName;    //类前缀
    BOOL                      _firstLower;         //首字母小写
}


@end
@implementation ModelStr


static ModelStr *instance = nil;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}




-(NSString *)CareModel:(NSString *)ModelName Datajson:(NSDictionary *)dict fixName:(NSString *)fixName{
    
    _classString = [NSMutableString new];
    _classMString = [NSMutableString new];
        [_classString deleteCharactersInRange:NSMakeRange(0, _classString.length)];
        [_classMString deleteCharactersInRange:NSMakeRange(0, _classMString.length)];
        NSString  * className = ModelName;
        NSString  * json = dict.toString;
        _classPrefixName = fixName;
        if(className == nil){
            className = DEFAULT_CLASS_NAME;
        }
        if(className.length == 0){
            className = DEFAULT_CLASS_NAME;
        }
        if(json && json.length){
            NSDictionary  * dict = nil;
            if([json hasPrefix:@"<"]){
                //xml
                dict = [XMLParser dictionaryForXMLString:json];
            }else{
                //json
                NSData  * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];

                dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:NULL];
                if (dict == nil) {
                    NSError *error;
                    NSPropertyListFormat plistFormat;
                    dict = [NSPropertyListSerialization propertyListWithData:jsonData options:NSPropertyListMutableContainers format:&plistFormat error:&error];
                }
            }
            if (dict == nil || ![NSJSONSerialization isValidJSONObject:dict]) {
//               @"未知数据格式无法解析(请提供json字符串或者dictionary字符串)"
            }
            NSString * classContent = [self handleDataEngine:dict key:@""];
            
            [_classString appendFormat:kHJ_CLASS,className,classContent];
            
           return _classString;

        }else{
//            @"json或者xml数据不能为空"
            return @"";
        }
    
    
    

}

- (NSString *)handleAfterClassName:(NSString *)className {
    if (className != nil && className.length > 0) {
        NSString * first = [className substringToIndex:1];
        NSString * other = [className substringFromIndex:1];
        return [NSString stringWithFormat:@"%@%@%@",_classPrefixName,[first uppercaseString],other];
    }
    return className;
}

- (NSString *)handlePropertyName:(NSString *)propertyName {
    if (_firstLower) {
        if (propertyName != nil && propertyName.length > 0) {
            NSString * first = [propertyName substringToIndex:1];
            NSString * other = [propertyName substringFromIndex:1];
            return [NSString stringWithFormat:@"%@%@",[first lowercaseString],other];
        }
    }
    return propertyName;
}

#pragma mark -解析处理引擎-

- (NSString*)handleDataEngine:(id)object key:(NSString*)key{
    if(object){
        NSMutableString  * property = [NSMutableString new];
        if([object isKindOfClass:[NSDictionary class]]){
            NSDictionary  * dict = object;
            [dict enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull subObject, BOOL * _Nonnull stop) {
                NSString * className = [self handleAfterClassName:key];
                NSString * propertyName = [self handlePropertyName:key];
                if([subObject isKindOfClass:[NSDictionary class]]){
                    NSString * classContent = [self handleDataEngine:subObject key:key];
                  [property appendFormat:PROPERTY('s'),className,propertyName];
          
                      [_classString appendFormat:kHJ_CLASS,className,classContent];
                }else if ([subObject isKindOfClass:[NSArray class]]){
                    id firstValue = nil;
                    NSString * classContent = nil;
                    if (((NSArray *)subObject).count > 0) {
                        firstValue = ((NSArray *)subObject).firstObject;
                    }else {
                        goto ARRAY_PASER;
                    }
                    if ([firstValue isKindOfClass:[NSString class]] ||
                        [firstValue isKindOfClass:[NSNumber class]]) {
                        if ([firstValue isKindOfClass:[NSString class]]) {
                            [property appendFormat:PROPERTY('c'),[NSString stringWithFormat:@"NSArray<%@ *>",@"NSString"],key];
                        }else {
                            [property appendFormat:PROPERTY('c'),[NSString stringWithFormat:@"NSArray<%@ *>",@"NSNumber"],key];
                        }
                    }else {
                    ARRAY_PASER:
                        classContent = [self handleDataEngine:subObject key:key];
                        [property appendFormat:PROPERTY('c'),[NSString stringWithFormat:@"NSArray<%@ *>",className],propertyName];
                                    
                       [_classString appendFormat:kHJ_CLASS,className,classContent];
                    }
                }else if ([subObject isKindOfClass:[NSString class]]){
                     [property appendFormat:PROPERTY('c'),@"NSString",propertyName];
                }else if ([subObject isKindOfClass:[NSNumber class]]){
                   
                    
                    if (strcmp([subObject objCType], @encode(float)) == 0 ||
                         strcmp([subObject objCType], @encode(CGFloat)) == 0) {
                         [property appendFormat:ASSIGN_PROPERTY,@"CGFloat",propertyName];
                     }else if (strcmp([subObject objCType], @encode(double)) == 0) {
                         [property appendFormat:ASSIGN_PROPERTY,@"double",propertyName];
                     }else if (strcmp([subObject objCType], @encode(BOOL)) == 0) {
                         [property appendFormat:ASSIGN_PROPERTY,@"BOOL",propertyName];
                     }else {
                         [property appendFormat:ASSIGN_PROPERTY,@"NSInteger",propertyName];
                     }
                    
                }else{
                    if(subObject == nil){
                        [property appendFormat:PROPERTY('c'),@"NSString",propertyName];
                    }else if([subObject isKindOfClass:[NSNull class]]){
                       
                        [property appendFormat:PROPERTY('c'),@"NSString",propertyName];
                    }
                }
            }];
        }else if ([object isKindOfClass:[NSArray class]]){
            NSArray  * dictArr = object;
            NSUInteger  count = dictArr.count;
            if(count){
                NSObject  * tempObject = dictArr[0];
                for (NSInteger i = 0; i < dictArr.count; i++) {
                    NSObject * subObject = dictArr[i];
                    if([subObject isKindOfClass:[NSDictionary class]]){
                        if(((NSDictionary *)subObject).count > ((NSDictionary *)tempObject).count){
                            tempObject = subObject;
                        }
                    }
                    if([subObject isKindOfClass:[NSDictionary class]]){
                        if(((NSArray *)subObject).count > ((NSArray *)tempObject).count){
                            tempObject = subObject;
                        }
                    }
                }
                [property appendString:[self handleDataEngine:tempObject key:key]];
            }
        }else{
            NSLog(@"key = %@",key);
        }

        return property;
    }
    return @"";
}





@end
