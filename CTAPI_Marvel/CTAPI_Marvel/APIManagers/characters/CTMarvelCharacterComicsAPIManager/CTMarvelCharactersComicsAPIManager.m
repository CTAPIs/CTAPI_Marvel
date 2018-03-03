//
//  CTMarvelCharacterComicsAPIManager.m
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CTMarvelCharactersComicsAPIManager.h"
#import "CTMarvelService.h"

NSString * const kCTMarvelCharacterComicsAPIManagerRequiredParamKeyCharacterId = @"characterId";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyNoVariants = @"noVariants";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDateRange = @"dateRange";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyTitle = @"title";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyTitleStartWith = @"titleStartWith";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyStartYear = @"startYear";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyIssueNumber = @"issueNumber";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDiamondCode = @"diamondCode";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDigitalId = @"digitalId";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyUPC = @"upc";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyISBN = @"isbn";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyEAN = @"ean";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyISSN = @"issn";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyHasDigitalIssue = @"hasDigitalIssue";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyModifiedSince = @"modifiedSince";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyCreators = @"creators";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeySeries = @"series";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyEvents = @"events";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyStories = @"stories";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeySharedAppearances = @"sharedAppearances";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyCollaborators = @"collaborators";

NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat = @"format";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_Comic = @"comic";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_Magzine = @"magazine";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_TradePaperback = @"trade paperback";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_Hardcover = @"hardcover";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_Digest = @"digest";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_GraphicNovel = @"graphic novel";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_DigitalComic = @"digital comic";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormat_value_InfiniteComic = @"infinite comic";

NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormatType = @"characterId";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormatType_Value_Comic = @"comic";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyFormatType_Value_Collection = @"collection";

NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDateDescriptor = @"dataDescriptor";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDateDescriptor_Value_LastWeek = @"lastWeek";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDateDescriptor_Value_ThisWeek = @"thisWeek";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDateDescriptor_Value_NextWeek = @"nextWeek";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyDateDescriptor_Value_ThisMonth = @"thisMonth";

NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyOrderBy = @"orderBy";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyOrderBy_Value_FocDate = @"focDate";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyOrderBy_Value_OnsaleDate = @"onsaleDate";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyOrderBy_Value_Title = @"title";
NSString * const kCTMarvelCharacterComicsAPIManagerOptionalParamKeyOrderBy_Value_IssueNumber = @"issueNumber";



@interface CTMarvelCharactersComicsAPIManager () <CTAPIManagerValidator>

@property (nonatomic, assign, readwrite) BOOL isFirstPage;
@property (nonatomic, assign, readwrite) BOOL isLastPage;
@property (nonatomic, assign, readwrite) NSUInteger pageNumber;
@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation CTMarvelCharactersComicsAPIManager

@synthesize errorMessage = _errorMessage;

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
        self.cachePolicy = CTAPIManagerCachePolicyNoCache;
        _pageSize = 10;
		_pageNumber = 0;
        _isFirstPage = YES;
        _isLastPage = NO;
    }
    return self;
}

#pragma mark - public methods
- (NSInteger)loadData
{
    [self cleanData];
    return [super loadData];
}

- (void)loadNextPage
{
    if (self.isLastPage) {
        if ([self.interceptor respondsToSelector:@selector(manager:didReceiveResponse:)]) {
            [self.interceptor manager:self didReceiveResponse:nil];
        }
        return;
    }

    if (!self.isLoading) {
        [super loadData];
    }
}

- (void)cleanData
{
    [super cleanData];
    self.isFirstPage = YES;
    self.pageNumber = 0;
}

- (NSDictionary *)reformParams:(NSDictionary *)params
{
    NSMutableDictionary *result = [params mutableCopy];
    if (result == nil) {
        result = [[NSMutableDictionary alloc] init];
    }
    
    if ([params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyCreators] isKindOfClass:[NSArray class]]) {
        NSArray *creators = params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyCreators];
        result[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyCreators] = [creators componentsJoinedByString:@","];
    }
    
    if ([params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeySeries] isKindOfClass:[NSArray class]]) {
        NSArray *series = params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeySeries];
        result[kCTMarvelCharacterComicsAPIManagerOptionalParamKeySeries] = [series componentsJoinedByString:@","];
    }
    
    if ([params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyEvents] isKindOfClass:[NSArray class]]) {
        NSArray *events = params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyEvents];
        result[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyEvents] = [events componentsJoinedByString:@","];
    }
    
    if ([params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyStories] isKindOfClass:[NSArray class]]) {
        NSArray *stories = params[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyStories];
        result[kCTMarvelCharacterComicsAPIManagerOptionalParamKeyStories] = [stories componentsJoinedByString:@","];
    }
    
    if (result[@"limit"] == nil) {
        result[@"limit"] = @(self.pageSize);
    } else {
        self.pageSize = [result[@"limit"] integerValue];
    }
    
    if (result[@"offset"] == nil) {
        if (self.isFirstPage == NO) {
            result[@"offset"] = @(self.pageNumber * self.pageSize);
        } else {
            result[@"offset"] = @(0);
        }
    } else {
        self.pageNumber = [result[@"offset"] unsignedIntegerValue] / self.pageSize;
    }
    
    return result;
}

#pragma mark - interceptors
- (BOOL)beforePerformSuccessWithResponse:(CTURLResponse *)response
{
    self.isFirstPage = NO;
    NSInteger totalPageCount = ceil([response.content[@"data"][@"total"] doubleValue]/(double)self.pageSize);
    if (self.pageNumber == totalPageCount - 1) {
        self.isLastPage = YES;
    } else {
        self.isLastPage = NO;
    }
    self.pageNumber++;
    return [super beforePerformSuccessWithResponse:response];
}

- (BOOL)beforePerformFailWithResponse:(CTURLResponse *)response
{
    [super beforePerformFailWithResponse:response];
    self.errorMessage = response.content[@"status"];
    return YES;
}

#pragma mark - CTAPIManager
- (NSString *)methodName
{
    NSString *characterId = [self.paramSource paramsForApi:self][kCTMarvelCharacterComicsAPIManagerRequiredParamKeyCharacterId];
    return [NSString stringWithFormat:@"characters/%@/comics", characterId];
}

- (NSString *)serviceIdentifier
{
    return CTServiceIdentifierMarvel;
}

- (CTAPIManagerRequestType)requestType
{
    return CTAPIManagerRequestTypeGet;
}

#pragma mark - CTAPIManagerValidator
- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    if (data[kCTMarvelCharacterComicsAPIManagerRequiredParamKeyCharacterId] == nil) {
        return CTAPIManagerErrorTypeParamsError;
    }
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return CTAPIManagerErrorTypeNoError;
}

#pragma mark - getters and setters
- (NSUInteger)currentPageNumber
{
    return self.pageNumber;
}

@end
