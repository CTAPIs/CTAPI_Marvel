//
//  CTMarvelService.m
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CTMarvelService.h"
#import <CTMediator/CTMediator.h>
#import <AFNetworking/AFNetworking.h>

NSString * const CTServiceIdentifierMarvel = @"CTMarvelService";

@interface CTMarvelService ()

@property (nonatomic, strong, readonly) NSURL *baseURL;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation CTMarvelService

#pragma mark - CTServiceProtocol
#pragma mark - public methods
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType
{
    if (requestType == CTAPIManagerRequestTypeGet) {
        NSString *urlString = [NSString stringWithFormat:@"%@:443/v1/public/%@", self.baseURL, methodName];
        
        NSString *tsString = [NSUUID UUID].UUIDString;
        NSString *privateKey = [[CTMediator sharedInstance] performTarget:@"CTMarvelKey" action:@"MarvelPrivateKey" params:nil shouldCacheTarget:YES];
        NSString *publicKey = [[CTMediator sharedInstance] performTarget:@"CTMarvelKey" action:@"MarvelPublicKey" params:nil shouldCacheTarget:YES];
        NSString *md5Hash = [[NSString stringWithFormat:@"%@%@%@", tsString, privateKey, publicKey] CT_MD5];
        
        NSMutableDictionary *finalParams = [params mutableCopy];
        finalParams[@"apikey"] = publicKey;
        finalParams[@"ts"] = tsString;
        finalParams[@"hash"] = md5Hash;
        
        NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET"
                                                                           URLString:urlString
                                                                          parameters:finalParams
                                                                               error:nil];
        return request;
    }
    
    return nil;
}

- (NSDictionary *)resultWithResponseData:(NSData *)responseData response:(NSURLResponse *)response request:(NSURLRequest *)request error:(NSError **)error
{
    if (responseData == nil) {
        return @{kCTApiProxyValidateResultKeyResponseJSONString:@"response is nil"};
    }
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    result[kCTApiProxyValidateResultKeyResponseData] = responseData;
    result[kCTApiProxyValidateResultKeyResponseJSONString] = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    result[kCTApiProxyValidateResultKeyResponseJSONObject] = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
    return result;
}

- (BOOL)handleCommonErrorWithResponse:(CTURLResponse *)response manager:(CTAPIBaseManager *)manager errorType:(CTAPIManagerErrorType)errorType {
    return YES;
}

#pragma mark - getters and setters
- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _sessionManager.securityPolicy = securityPolicy;
    }
    return _sessionManager;
}

- (NSURL *)baseURL
{
    if (self.apiEnvironment == CTServiceAPIEnvironmentRelease) {
        return [NSURL URLWithString:@"https://gateway.marvel.com"];
    }
    if (self.apiEnvironment == CTServiceAPIEnvironmentDevelop) {
        return [NSURL URLWithString:@"https://gateway.marvel.com"];
    }
    if (self.apiEnvironment == CTServiceAPIEnvironmentReleaseCandidate) {
        return [NSURL URLWithString:@"https://gateway.marvel.com"];
    }
    return [NSURL URLWithString:@"https://gateway.marvel.com"];
}

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        [_httpRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpRequestSerializer;
}

@end
