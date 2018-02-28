//
//  CTMarvelCharactersAPIManager.h
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import <CTNetworking/CTNetworking.h>

extern NSString * const kCTMarvelCharactersAPIManagerParamKey<#API param name#>;

@interface CTMarvelCharactersAPIManager : CTAPIBaseManager <CTAPIManager, CTPagableAPIManager>

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSUInteger currentPageNumber;
@property (nonatomic, assign, readonly) BOOL isLastPage;

- (void)loadNextPage;

@end
