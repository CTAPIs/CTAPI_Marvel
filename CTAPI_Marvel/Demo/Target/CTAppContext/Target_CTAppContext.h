//
//  Target_CTAppContext.h
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_CTAppContext : NSObject

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params;
- (BOOL)Action_isReachable:(NSDictionary *)params;
- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params;

@end
