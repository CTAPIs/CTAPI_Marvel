//
//  CTMarvelService.h
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CTNetworking/CTNetworking.h>

extern NSString * const CTServiceIdentifierMarvel;

@interface CTMarvelService : NSObject <CTServiceProtocol>

@property (nonatomic, assign) CTServiceAPIEnvironment apiEnvironment;

@end
