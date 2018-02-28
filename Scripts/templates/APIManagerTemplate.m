//
//  __APIManagerFileName__.m
//  APIManagers
//
//  Created by casa's script.
//  Copyright © __year__年 casa. All rights reserved.
//

#import "__APIManagerFileName__.h"

NSString * const k__APIManagerFileName__ParamKey<#API param name#> = @"<#API param name#>";

@interface __APIManagerFileName__ () <CTAPIManagerValidator>

@property (nonatomic, strong, readwrite) NSString *errorMessage;

@end

@implementation __APIManagerFileName__

@synthesize errorMessage = _errorMessage;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validator = self;
        self.cachePolicy = __CachePolicy__;
    }
    return self;
}

#pragma mark - CTAPIManager
- (NSString *)methodName
{
    return @"__MethodName__";
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
