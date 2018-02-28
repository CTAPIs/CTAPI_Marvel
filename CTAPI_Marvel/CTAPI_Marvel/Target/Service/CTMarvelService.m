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

@property (nonatomic, strong, readonly) NSString *baseURL;
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation CTMarvelService

#pragma mark - CTServiceProtocol
#pragma mark - public methods
- (NSURLRequest *)requestWithParams:(NSDictionary *)params methodName:(NSString *)methodName requestType:(CTAPIManagerRequestType)requestType
{
    if (requestType == CTAPIManagerRequestTypeGet) {
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, methodName];
        
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
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    result[kCTApiProxyValidateResultKeyResponseData] = responseData;
    result[kCTApiProxyValidateResultKeyResponseJSONString] = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    result[kCTApiProxyValidateResultKeyResponseJSONObject] = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
    return result;
}

#pragma mark - getters and setters
- (NSString *)baseURL
{
    if (self.apiEnvironment == CTServiceAPIEnvironmentRelease) {
        return @"https://gateway.marvel.com:443/v1/public";
    }
    if (self.apiEnvironment == CTServiceAPIEnvironmentDevelop) {
        return @"https://gateway.marvel.com:443/v1/public";
    }
    if (self.apiEnvironment == CTServiceAPIEnvironmentReleaseCandidate) {
        return @"https://gateway.marvel.com:443/v1/public";
    }
    return @"https://gateway.marvel.com:443/v1/public";
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
