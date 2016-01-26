//
//  Seconddata.m
//  吃货
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "Seconddata.h"
#import "NSString+GetUrl.h"

@implementation Seconddata

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
    {
        if ([key isEqualToString:@"id"]) {
           _ID = value;
        }


}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        _imgUrl1 = [NSString getImageUrlStr:dict[@"imageid"]];
                
     [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}



@end
