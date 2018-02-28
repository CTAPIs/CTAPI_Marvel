//
//  ChracterAPIViewController.m
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "CharacterAPIViewController.h"
#import "CharacterAPIViewController+APIParams.h"

#import "CTMarvelCharactersAPIManager.h"
#import "CTMarvelCharacterByIdAPIManager.h"
#import "CTMarvelCharacterComicsAPIManager.h"

@interface CharacterAPIViewController () <CTAPIManagerParamSource>

@end

@implementation CharacterAPIViewController

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager
{
    if ([manager isKindOfClass:[CTMarvelCharacterByIdAPIManager class]]) {
        return [self paramsForCharacterById];
    }
    if ([manager isKindOfClass:[CTMarvelCharactersAPIManager class]]) {
        return [self paramsForCharacterList];
    }
    if ([manager isKindOfClass:[CTMarvelCharacterComicsAPIManager class]]) {
        return [self paramsForComicList];
    }
    return nil;
}

#pragma mark - getters and setters
- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            kBaseAPIViewControllerDataSourceTitle:@"Marvel Character List",
                            kBaseAPIViewControllerDataSourceClass:[CTMarvelCharactersAPIManager class]
                            },
                        @{
                            kBaseAPIViewControllerDataSourceTitle:@"Marvel Character By ID",
                            kBaseAPIViewControllerDataSourceClass:[CTMarvelCharacterByIdAPIManager class]
                            },
                        @{
                            kBaseAPIViewControllerDataSourceTitle:@"Marvel Character Comic List By ID",
                            kBaseAPIViewControllerDataSourceClass:[CTMarvelCharacterComicsAPIManager class]
                            },
                        ];
    }
    return _dataSource;
}

@end
