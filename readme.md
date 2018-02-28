![MARVEL](https://i.annihil.us/u/prod/misc/marvel.svg)

[MARVEL API Document](https://developer.marvel.com/docs)

pod "CTAPI_Marvel"

How To Use It
=============

- apply private key and public key from Marvel:[https://developer.marvel.com](https://developer.marvel.com)
- add `pod "CTAPI_Marvel"` in your Podfile
- create an Object named `Target_CTMarvelKey` in your own project

```objective-c
@implementation Target_CTMarvelKey

- (NSString *)Action_MarvelPublicKey:(NSDictionary *)params
{
    return @"your public key";
}

- (NSString *)Action_MarvelPrivateKey:(NSDictionary *)params
{
    return @"your private key";
}

@end
```

- create an Object named `CTAppContext` in your own project (for [CTNetworking](https://github.com/casatwy/CTNetworking))

```objective-c
@implementation Target_CTAppContext

- (BOOL)Action_isReachable:(NSDictionary *)params
{
    return YES;
}

- (NSInteger)Action_cacheResponseCountLimit:(NSDictionary *)params
{
    return 2;
}

- (BOOL)Action_shouldPrintNetworkingLog:(NSDictionary *)params
{
    return YES;
}

@end
```

- haa! you can use MARVEL API now!
