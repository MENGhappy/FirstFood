//
//  TZsecondcell.h
//  吃货
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZsecondcell : NSObject

@property (nonatomic,strong) NSString *imageidurl;
@property (nonatomic,strong) NSString *details;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)dataWithDictionary:(NSDictionary *)dict;




@end
