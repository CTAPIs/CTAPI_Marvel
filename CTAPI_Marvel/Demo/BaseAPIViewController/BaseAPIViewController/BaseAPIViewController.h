//
//  BaseAPIViewController.h
//  BLAPIManagers
//
//  Created by casa on 2017/2/7.
//  Copyright © 2017年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CTNetworking/CTNetworking.h>

extern NSString * const kBaseAPIViewControllerUITableViewCellIdentifier;
extern NSString * const kBaseAPIViewControllerDataSourceTitle;
extern NSString * const kBaseAPIViewControllerDataSourceClass;

@interface BaseAPIViewController : UIViewController <CTAPIManagerCallBackDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSArray * _dataSource;
}

@property (nonatomic, strong) NSArray *dataSource;

@end
