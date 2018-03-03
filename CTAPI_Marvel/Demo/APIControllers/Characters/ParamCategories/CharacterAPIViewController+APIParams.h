//
//  CharacterAPIViewController+APIParams.h
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//


#import "CharacterAPIViewController.h"

#import "CTMarvelCharacterByIdAPIManager.h"
#import "CTMarvelCharactersAPIManager.h"
#import "CTMarvelCharactersComicsAPIManager.h"
#import "CTMarvelCharactersEventsAPIManager.h"

@interface CharacterAPIViewController (APIParams)

- (NSDictionary *)paramsForCharacterById;
- (NSDictionary *)paramsForCharacterList;
- (NSDictionary *)paramsForComicList;
- (NSDictionary *)paramsForEventList;

@end
