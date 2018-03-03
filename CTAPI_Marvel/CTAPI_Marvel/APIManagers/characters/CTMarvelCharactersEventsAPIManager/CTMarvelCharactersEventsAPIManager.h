//
//  CTMarvelCharactersEventsAPIManager.h
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <CTNetworking/CTNetworking.h>

extern NSString * const kCTMarvelCharactersEventsAPIManagerRequiredParamKeyCharacterID;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyFilterByName;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyEventStartByName;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyModifiedSince;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyCreators;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeySeries;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyComics;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyStories;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy_Value_NameASC;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy_Value_NameDESC;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy_Value_ModifiedASC;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy_Value_ModifiedDESC;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy_Value_StartDateASC;
extern NSString * const kCTMarvelCharactersEventsAPIManagerOptionalParamKeyOrderBy_Value_StartDateDESC;

@interface CTMarvelCharactersEventsAPIManager : CTAPIBaseManager <CTAPIManager, CTPagableAPIManager>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isLastPage;

- (void)loadNextPage;

@end
