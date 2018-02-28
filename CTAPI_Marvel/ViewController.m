//
//  ViewController.m
//  CTAPI_Marvel
//
//  Created by casa on 2018/2/28.
//  Copyright © 2018年 casa. All rights reserved.
//

#import "ViewController.h"
#import <CTNetworking/CTNetworking.h>
#import "CTMarvelService.h"
#import <HandyFrame/UIView+LayoutMethods.h>

#import "CharacterAPIViewController.h"

NSString * kViewControllerCellIdentifier = @"kViewControllerCellIdentifier";
NSString * kViewControllerDataSourceKeyTitle = @"kViewControllerDataSourceKeyTitle";
NSString * kViewControllerDataSourceKeyClass = @"kViewControllerDataSourceKeyClass";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UISegmentedControl *enviromentSegment;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.enviromentSegment];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView fill];
    
    [self.enviromentSegment sizeToFit];
    [self.enviromentSegment centerEqualToView:self.navigationController.navigationBar];
    [self.enviromentSegment rightInContainer:8 shouldResize:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class viewControllerClass = self.dataSource[indexPath.row][kViewControllerDataSourceKeyClass];
    UIViewController *viewController = [[viewControllerClass alloc] init];
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kViewControllerCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row][kViewControllerDataSourceKeyTitle];
    return cell;
}

#pragma mark - event response
- (void)didChangedEnviromentSegment:(UISegmentedControl *)enviromentSegment
{
    id <CTServiceProtocol> service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:CTServiceIdentifierMarvel];
    if (enviromentSegment.selectedSegmentIndex == 0) {
        service.apiEnvironment = CTServiceAPIEnvironmentDevelop;
    }
    if (enviromentSegment.selectedSegmentIndex == 1) {
        service.apiEnvironment = CTServiceAPIEnvironmentReleaseCandidate;
    }
    if (enviromentSegment.selectedSegmentIndex == 2) {
        service.apiEnvironment = CTServiceAPIEnvironmentRelease;
    }
}

#pragma mark - getters and setters
- (UISegmentedControl *)enviromentSegment
{
    if (_enviromentSegment == nil) {
        _enviromentSegment = [[UISegmentedControl alloc] initWithItems:@[@"Develop", @"Pre-release", @"Release"]];
        id <CTServiceProtocol> service = [[CTServiceFactory sharedInstance] serviceWithIdentifier:CTServiceIdentifierMarvel];
        if (service.apiEnvironment == CTServiceAPIEnvironmentDevelop) {
            [_enviromentSegment setSelectedSegmentIndex:0];
        }
        if (service.apiEnvironment == CTServiceAPIEnvironmentReleaseCandidate) {
            [_enviromentSegment setSelectedSegmentIndex:1];
        }
        if (service.apiEnvironment == CTServiceAPIEnvironmentRelease) {
            [_enviromentSegment setSelectedSegmentIndex:2];
        }
        [_enviromentSegment addTarget:self action:@selector(didChangedEnviromentSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _enviromentSegment;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kViewControllerCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            kViewControllerDataSourceKeyTitle:@"CharacterAPI",
                            kViewControllerDataSourceKeyClass:[CharacterAPIViewController class]
                            },
                        ];
    }
    return _dataSource;
}


@end
