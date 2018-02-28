//
//  BaseAPIViewController.m
//  BLAPIManagers
//
//  Created by casa on 2017/2/7.
//  Copyright © 2017年 casa. All rights reserved.
//

#import "BaseAPIViewController.h"

#import <HandyFrame/UIView+LayoutMethods.h>
#import "BLAPIManagerTableViewCell.h"
#import "ResultView.h"
#import "CTPageAPIViewController.h"

NSString * const kBaseAPIViewControllerUITableViewCellIdentifier = @"kBaseAPIViewControllerUITableViewCellIdentifier";
NSString * const kBaseAPIViewControllerDataSourceTitle = @"kBaseAPIViewControllerDataSourceTitle";
NSString * const kBaseAPIViewControllerDataSourceClass = @"kBaseAPIViewControllerDataSourceClass";

@interface BaseAPIViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CTAPIBaseManager *apiManager;
@property (nonatomic, weak) id<CTAPIManagerParamSource> paramSource;

@end

@implementation BaseAPIViewController

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(CTAPIManagerParamSource)]) {
            self.paramSource = (id<CTAPIManagerParamSource>)self;
        } else {
            NSLog(@"%@ must confirm to <CTAPIManagerParamSource>", self.class);
            assert(false);
            return nil;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView fill];
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager
{
    [ResultView configWithString:manager.response.logString inView:self.view];
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
{
    [ResultView configWithString:manager.response.logString inView:self.view];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class apiManagerClass = self.dataSource[indexPath.row][kBaseAPIViewControllerDataSourceClass];
    self.apiManager = [[apiManagerClass alloc] init];
    self.apiManager.paramSource = self.paramSource;
    
    if ([self.apiManager conformsToProtocol:@protocol(CTPagableAPIManager)]) {
        CTPageAPIViewController *viewController = [[CTPageAPIViewController alloc] init];
        viewController.apiManager = (CTAPIBaseManager <CTPagableAPIManager> *)self.apiManager;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        self.apiManager.delegate = self;
        [self.apiManager loadData];
        [ResultView showInView:self.view];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLAPIManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBaseAPIViewControllerUITableViewCellIdentifier];

    if (cell == nil) {
        cell = [[BLAPIManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kBaseAPIViewControllerUITableViewCellIdentifier];
    }

    [cell configWithTitleString:[NSString stringWithFormat:@"%@", self.dataSource[indexPath.row][kBaseAPIViewControllerDataSourceClass]] detailString:self.dataSource[indexPath.row][kBaseAPIViewControllerDataSourceTitle]];

    return cell;
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
