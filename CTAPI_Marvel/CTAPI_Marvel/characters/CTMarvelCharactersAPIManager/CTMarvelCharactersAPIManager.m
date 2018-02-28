//
//  CTMarvelCharactersAPIManager.m
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CTMarvelCharactersAPIManager.h"

NSString * const kCTMarvelCharactersAPIManagerParamKey<#API param name#> = @"<#API param name#>";

@interface CTMarvelCharactersAPIManager () <CTAPIManagerValidator>

@property (nonatomic, assign, readwrite) BOOL isFirstPage;
@property (nonatomic, assign, readwrite) BOOL isLastPage;
@property (nonatomic, assign, readwrite) NSUInteger pageNumber;
@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation CTMarvelCharactersAPIManager

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

    if (result[<# key of page size #>] == nil) {
        result[<# key of page size #>] = @(self.pageSize);
    } else {
        self.pageSize = [result[<# key of page size #>] integerValue];
    }
    
    if (result[<# key of page number #>] == nil) {
        if (self.isFirstPage == NO) {
            result[<# key of page number #>] = @(self.pageNumber);
        } else {
            result[<# key of page number #>] = @(0);
        }
    } else {
        self.pageNumber = [result[<# key of page number #>] unsignedIntegerValue];
    }
    
    return result;
}

#pragma mark - interceptors
- (BOOL)beforePerformSuccessWithResponse:(CTURLResponse *)response
{
    self.isFirstPage = NO;
    NSInteger totalPageCount = integerFromObject(response.content, <# total page key #>);
    if (self.pageNumber == totalPageCount) {
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
    self.errorMessage = <# fetch error message #>;
    return YES;
}

#pragma mark - CTAPIManager
- (NSString *)methodName
{
    return @"characters";
}

- (NSString *)serviceType
{
    return __ServiceType__;
}

- (CTAPIManagerRequestType)requestType
{
    return __RequestType__;
}

#pragma mark - CTAPIManagerValidator
- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    return CTAPIManagerErrorTypeNoError;
}

#pragma mark - getters and setters
- (NSUInteger)currentPageNumber
{
    return self.pageNumber - 1;
}

@end
