//
//  Target_CTMarvelKey.h
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_CTMarvelKey : NSObject

- (NSString *)Action_MarvelPublicKey:(NSDictionary *)params;
- (NSString *)Action_MarvelPrivateKey:(NSDictionary *)params;

@end
