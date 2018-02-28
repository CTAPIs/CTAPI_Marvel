//
//  BLAPIManagerTableViewCell.m
//  BLAPIManagers
//
//  Created by casa on 2016/11/29.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "BLAPIManagerTableViewCell.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@implementation BLAPIManagerTableViewCell

#pragma mark - life cycle
- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.textLabel topInContainer:5 shouldResize:NO];

    [self.detailTextLabel sizeToFit];
    [self.detailTextLabel leftEqualToView:self.textLabel];
    [self.detailTextLabel bottomInContainer:5 shouldResize:NO];
}

- (void)configWithTitleString:(NSString *)title detailString:(NSString *)detailString
{
    self.textLabel.text = title;
    self.detailTextLabel.text = detailString;
    [self layoutSubviews];
}

@end
