
#import "MJExtension.h"
#import "NSObject+MJParse.h"

@implementation NSObject (MJParse)


+ (id)MTMJParse:(id)responseObj
{
    if ([responseObj isKindOfClass:[NSArray class]])
    {
        return [self mj_objectArrayWithKeyValuesArray:responseObj];
    }
    if ([responseObj isKindOfClass:[NSDictionary class]])
    {
        return [self mj_objectWithKeyValues:responseObj];
    }
    
    return responseObj;
}



@end
