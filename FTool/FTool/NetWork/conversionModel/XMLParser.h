//
//  XMLParser.h
//  FTool
//
//  Created by jie.huang on 26/4/2020.
//  Copyright © 2020 jie.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum:NSInteger {
    XMLParserOptionsProcessNamespaces           = 1 << 0,
    XMLParserOptionsReportNamespacePrefixes     = 1 << 1,
    XMLParserOptionsResolveExternalEntities     = 1 << 2,
}XMLParserOptions;

@interface XMLParser : NSObject

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string;
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLParserOptions)options;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLParserOptions)options;

@end

NS_ASSUME_NONNULL_END
