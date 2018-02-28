//
//  BLQueryBrandActivityListAPIViewController.m
//  BLAPIManagers
//
//  Created by 潘灵 on 16/12/7.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "CTPageAPIViewController.h"

#import <HandyFrame/UIView+LayoutMethods.h>

@interface CTPageAPIViewController () <CTAPIManagerCallBackDelegate, CTAPIManagerInterceptor, CTAPIManagerParamSource>

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *loadFirstPageButton;
@property (nonatomic, strong) UIButton *loadNextPageButton;

@end

@implementation CTPageAPIViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.loadFirstPageButton];
    [self.view addSubview:self.loadNextPageButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self.loadFirstPageButton sizeToFit];
    [self.loadFirstPageButton centerEqualToView:self.view];

    [self.statusLabel sizeToFit];
    [self.statusLabel fillWidth];
    [self.statusLabel bottom:50 FromView:self.loadFirstPageButton];
    
    [self.loadNextPageButton sizeToFit];
    [self.loadNextPageButton centerXEqualToView:self.view];
    [self.loadNextPageButton top:50 FromView:self.loadFirstPageButton];
}

- (void)manager:(CTAPIBaseManager *)manager didReceiveResponse:(CTURLResponse *)response
{
    if (self.apiManager.isLastPage) {
        self.statusLabel.text = [NSString stringWithFormat:@"reached last page %lu", (unsigned long)self.apiManager.currentPageNumber];
    }
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager
{
    if (self.apiManager.isLastPage) {
        self.statusLabel.text = [NSString stringWithFormat:@"reached last page %lu", (unsigned long)self.apiManager.currentPageNumber];
    } else {
        self.statusLabel.text = [NSString stringWithFormat:@"page %lu finished", (unsigned long)self.apiManager.currentPageNumber];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
{
    self.statusLabel.text = @"fail";
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager
{
#warning todo
    return @{};
}

#pragma mark - event response
- (void)didTappedLoadFirstPageButton:(UIButton *)button
{
    self.statusLabel.text = @"loading...";
    [self.apiManager loadData];
}

- (void)didTappedLoadNextPageButton:(UIButton *)button
{
    self.statusLabel.text = @"loading...";
    [self.apiManager loadNextPage];
}

#pragma mark - getter and setters
- (UIButton *)loadFirstPageButton
{
    if (_loadFirstPageButton == nil) {
        _loadFirstPageButton = [[UIButton alloc] init];
        [_loadFirstPageButton addTarget:self action:@selector(didTappedLoadFirstPageButton:) forControlEvents:UIControlEventTouchUpInside];

        [_loadFirstPageButton setTitle:@"First Page" forState:UIControlStateNormal];
        [_loadFirstPageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_loadFirstPageButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        
    }
    return _loadFirstPageButton;
}

- (UIButton *)loadNextPageButton
{
    if (_loadNextPageButton == nil) {
        _loadNextPageButton = [[UIButton alloc] init];
        [_loadNextPageButton addTarget:self action:@selector(didTappedLoadNextPageButton:) forControlEvents:UIControlEventTouchUpInside];

        [_loadNextPageButton setTitle:@"Next Page" forState:UIControlStateNormal];
        [_loadNextPageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_loadNextPageButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    }
    return _loadNextPageButton;
}

- (void)setApiManager:(CTAPIBaseManager<CTPagableAPIManager> *)apiManager
{
    _apiManager = apiManager;
    _apiManager.delegate = self;
    _apiManager.interceptor = self;
}

- (UILabel *)statusLabel
{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"...";
        _statusLabel.textColor = [UIColor blueColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
@end
