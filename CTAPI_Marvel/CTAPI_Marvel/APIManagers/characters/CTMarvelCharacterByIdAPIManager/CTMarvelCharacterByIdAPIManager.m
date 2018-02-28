//
//  CTMarvelCharacterByIdAPIManager.m
//  APIManagers
//
//  Created by casa's script.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CTMarvelCharacterByIdAPIManager.h"
#import "CTMarvelService.h"

NSString * const kCTMarvelCharacterByIdAPIManagerParamKeyCharacterID = @"kCTMarvelCharacterByIdAPIManagerParamKeyCharacterID";

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
    NSString *characterId = [self.paramSource paramsForApi:self][kCTMarvelCharacterByIdAPIManagerParamKeyCharacterID];
    return [NSString stringWithFormat:@"characters/%@", characterId];
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
    self.errorMessage = response.content[@"status"];
    return YES;
}

@end
