//
//  Fourcell.m
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "Fourcell.h"
#import "NSString+GetUrl.h"

@implementation Fourcell

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        _imageUrl= [NSString getImageUrlStr:dict[@"imageid"]];
        
        NSArray *arr = [dict[@"uri"]componentsSeparatedByString:@"="];
        _ID = [arr lastObject];
        //NSLog(@"_ID%@",_ID);
      
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}


@end
