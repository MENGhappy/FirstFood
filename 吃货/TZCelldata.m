//
//  TZCelldata.m
//  吃货
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "TZCelldata.h"

#import "NSString+GetUrl.h"

@implementation TZCelldata


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
       
       _imgUrl = [NSString getImageUrlStr:dict[@"imageid"]];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}



@end
