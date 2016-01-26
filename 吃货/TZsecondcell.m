//
//  TZsecondcell.m
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZsecondcell.h"
#import "NSString+GetUrl.h"

@implementation TZsecondcell


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _imageidurl = [NSString getImageUrlStr:dict[@"imageid"]];
    }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}




@end
