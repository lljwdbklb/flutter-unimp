//
//  DCMiniAppSplashView.m
//  HelloMiniAppDemo
//
//  Created by XHY on 2020/2/6.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "FlutterUnimpSplashView.h"

@interface FlutterUnimpSplashView()
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation FlutterUnimpSplashView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupFrames];
    }
    return self;
}

- (void)setupFrames {
    [self addSubview:self.indicatorView];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *xCenter = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *yCenter = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraints:@[xCenter, yCenter]];
    NSLayoutConstraint *w = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [self.indicatorView addConstraints:@[w, h]];
    [self.indicatorView startAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.indicatorView startAnimating];
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    }
    return _indicatorView;
}
@end
