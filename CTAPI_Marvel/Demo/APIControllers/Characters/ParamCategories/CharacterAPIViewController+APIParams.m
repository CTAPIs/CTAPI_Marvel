//
//  CharacterAPIViewController+APIParams.m
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CharacterAPIViewController+APIParams.h"
#import "CTMarvelCharacterByIdAPIManager.h"

@implementation CharacterAPIViewController (APIParams)

- (NSDictionary *)paramsForCharacterById
{
    return @{kCTMarvelCharacterByIdAPIManagerParamKeyCharacterID:@"1011334"};
}

- (NSDictionary *)paramsForCharacterList
{
    return nil;
}

@end
