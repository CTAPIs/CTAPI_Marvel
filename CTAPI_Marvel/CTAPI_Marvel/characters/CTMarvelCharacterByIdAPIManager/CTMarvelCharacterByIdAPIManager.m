//
//  CTMarvelCharacterByIdAPIManager.m
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CTMarvelCharacterByIdAPIManager.h"

NSString * const kCTMarvelCharacterByIdAPIManagerParamKey<#API param name#> = @"<#API param name#>";

@interface CTMarvelCharacterByIdAPIManager () <CTAPIManagerValidator>

@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation CTMarvelCharacterByIdAPIManager

@synthesize errorMessage = _errorMessage;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
        self.cachePolicy = CTAPIManagerCachePolicyNoCache;
    }
    return self;
}

#pragma mark - CTAPIManager
- (NSString *)methodName
{
    return @"characters/characterId";
}

- (NSString *)serviceIdentifier
{
    return <# service identifier #>;
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

#pragma mark - interceptors
- (BOOL)beforePerformFailWithResponse:(CTURLResponse *)response
{
    [super beforePerformFailWithResponse:response];
    self.errorMessage = <# fetch error message #>;
    return YES;
}

@end
