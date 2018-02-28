//
//  ResultView.m
//  BLAPIManagers
//
//  Created by casa on 2016/12/20.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "ResultView.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface ResultView ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation ResultView

#pragma mark - public methods
+ (void)showInView:(UIView *)view
{
    ResultView *instanceView = [[ResultView alloc] init];
    instanceView.alpha = 0.0f;
    [view addSubview:instanceView];
    [instanceView fill];
    [instanceView topInContainer:64 shouldResize:YES];
    [UIView animateWithDuration:0.3f animations:^{
        instanceView.alpha = 1.0f;
    }];
}

+ (void)configWithString:(NSString *)resultString inView:(UIView *)view
{
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ResultView class]]) {
            ResultView *instanceView = (ResultView *)obj;
            instanceView.textView.text = resultString;
            [instanceView.activityIndicatorView stopAnimating];
            [UIView animateWithDuration:0.3f animations:^{
                [instanceView layoutSubviews];
            }];
            *stop = YES;
        }
    }];
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f];
        [self.textView addGestureRecognizer:self.tapGestureRecognizer];

        [self addSubview:self.textView];
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.textView.text.length == 0) {
        self.activityIndicatorView.ct_size = CGSizeMake(200, 200);
        self.textView.frame = CGRectZero;
    } else {
        self.activityIndicatorView.frame = CGRectZero;
        self.textView.ct_size = CGSizeMake(self.ct_width - 20, self.ct_height - 20);
    }
    [self.activityIndicatorView centerEqualToView:self];
    [self.textView centerEqualToView:self];
}

#pragma mark - event response
- (void)didRecognizedTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - getters and setters
- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:12];
        _textView.text = @"";
        _textView.editable = NO;
        _textView.layer.cornerRadius = 4.0f;
    }
    return _textView;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizedTapGestureRecognizer:)];
    }
    return _tapGestureRecognizer;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.color = [UIColor grayColor];
        _activityIndicatorView.backgroundColor = [UIColor whiteColor];
        _activityIndicatorView.layer.cornerRadius = 4.0f;
        [_activityIndicatorView startAnimating];
    }
    return _activityIndicatorView;
}

@end
