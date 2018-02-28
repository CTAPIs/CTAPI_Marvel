//
//  ResultView.h
//  BLAPIManagers
//
//  Created by casa on 2016/12/20.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultView : UIView

+ (void)showInView:(UIView *)view;
+ (void)configWithString:(NSString *)resultString inView:(UIView *)view;

@end
