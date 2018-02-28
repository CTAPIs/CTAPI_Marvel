//
//  CTMarvelCharactersAPIManager.h
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <CTNetworking/CTNetworking.h>

extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamName;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamNameStartsWith;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamModifiedSince;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamComicIDList;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamSeriesIDList;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamEventIDList;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamStoryIDList;

extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamOrderBy;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamOrderBy_Value_orderByNameASC;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamOrderBy_Value_orderByNameDESC;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamOrderBy_Value_orderByModifiedASC;
extern NSString * const kCTMarvelCharactersAPIManagerOptionalParamOrderBy_Value_orderByModifiedDESC;

@interface CTMarvelCharactersAPIManager : CTAPIBaseManager <CTAPIManager, CTPagableAPIManager>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isLastPage;

- (void)loadNextPage;

@end
