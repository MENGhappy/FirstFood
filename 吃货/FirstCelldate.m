//
//  Celldate.m
//  吃货GOGOGO
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FirstCelldate.h"
#import "NSString+GetUrl.h"

@implementation FirstCelldate

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
         _firstID= value;
    }
}
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.url = [NSString getImageUrlStr:dict[@"picid"]];
        self.imaUrl = [NSString getImageUrlStr:dict[@"pic"]];
        [self setValuesForKeysWithDictionary:dict];
                }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
