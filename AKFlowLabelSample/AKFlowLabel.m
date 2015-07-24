//
//  AKFlowLabel.m
//  AKFlowLabelSample
//
//  Created by Aston K Mac on 15/7/22.
//  Copyright (c) 2015年 Aston K Mac. All rights reserved.
//


#import "AKFlowLabel.h"

const NSTimeInterval kAnmationDelay = 3.f;//Label Stay Time for Reading
const NSTimeInterval  kAnimationDuration = .4f; //Moving Speed

const CGFloat kHeightLabel  = 40.f;//Animate Distance

@interface AKFlowLabel ()
@property (nonatomic,strong) UILabel *theLabel;

@property (nonatomic, strong) NSLayoutConstraint *aglineYLayout;
@end

@implementation AKFlowLabel

- (NSString *)defaultText
{
    if (_defaultText == nil || [_defaultText isEqualToString:@""]) {
        _defaultText = @"暂无通知";
    }
    return _defaultText;
}

- (void)setNotiStrings:(NSArray *)notiStrings
{
    _notiStrings = [notiStrings copy];
    if (notiStrings == nil || notiStrings.count == 0) {
        notiStrings = @[self.defaultText];
    }
    _curIndex = 0;
    [self setUpLabel];
    if (notiStrings.count > 1) {
        [self startFlow];
    }else{
        [self reset];
    }
}

- (void)setNotiStrings:(NSArray *)notiStrings withStartIndex:(NSInteger) index
{
    _notiStrings = [notiStrings copy];
    if (notiStrings == nil || notiStrings.count == 0) {
        notiStrings = @[self.defaultText];
    }
    _curIndex = index;
    if (_curIndex >= notiStrings.count) {
        _curIndex = 0;
    }
    [self setUpLabel];
    if (notiStrings.count > 1) {
        [self startFlow];
    }else{
        [self reset];
    }
}

- (void)setUpLabel
{
  
    
    //Without listening, when user came back from other application, animation  stops and everything goes white. I have no idea what happen. So I have to restart the animation.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startListenActive) name:UIApplicationWillResignActiveNotification  object:nil];
    
    self.clipsToBounds = YES;
    if (self.theLabel) {
        [self reset];
    }else{
        [self buildTheUI];
    }
    
}

- (void)startListenActive{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetAndStartFlow) name:UIApplicationDidBecomeActiveNotification  object:nil];
}

- (void)buildTheUI
{
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor clearColor];
    lb.text = self.notiStrings[_curIndex];
    lb.textColor  = [UIColor blackColor];
    self.theLabel = lb;
    [self addSubview:lb];
    
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *HStr = @"H:|[label]|";
    NSDictionary *bindings = @{
                               @"label":lb
                               };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:HStr options:NSLayoutFormatAlignAllCenterY metrics:nil views:bindings]];
    NSLayoutConstraint *AglineYConstraint = [NSLayoutConstraint constraintWithItem:lb attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    self.aglineYLayout = AglineYConstraint;
    [self addConstraint:AglineYConstraint];
    
    
    
    //addGesture
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)]];
}

- (void)actionTap
{
    if (self.blockTap) {
        self.blockTap(self, _curIndex);
    }
}


- (void)animateTransForm
{
    
    [UIView animateWithDuration:kAnimationDuration delay:kAnmationDelay options:UIViewAnimationOptionCurveLinear animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.theLabel.transform = CGAffineTransformMakeTranslation(0, -kHeightLabel);
        self.theLabel.alpha  = 0.f;
    } completion:^(BOOL Afinished) {
        if (Afinished) {
            self.theLabel.transform = CGAffineTransformMakeTranslation(0, kHeightLabel);
            [UIView animateWithDuration:kAnimationDuration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
                self.theLabel.transform = CGAffineTransformIdentity;
                self.theLabel.alpha = 1.f;
                
                //Change Text
                _curIndex++;
                if (_curIndex >= self.notiStrings.count ) {
                    _curIndex = 0;
                }
                self.theLabel.text = self.notiStrings[_curIndex];
                
            } completion:^(BOOL Bfinished) {
                if (Bfinished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    _curIndex++;
                    [self performSelector:_cmd];
#pragma clang diagnostic pop
                }
            }];
        }
    }];
}


- (void)animateLayout
{

  
    [UIView animateWithDuration:kAnimationDuration delay:kAnmationDelay options:UIViewAnimationOptionCurveLinear animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.aglineYLayout.constant = -kHeightLabel;
        self.theLabel.alpha = 0.f;
        [self layoutIfNeeded];
    } completion:^(BOOL Afinished) {
        if (Afinished) {
            self.aglineYLayout.constant = kHeightLabel;
            [self layoutIfNeeded];
            [UIView animateWithDuration:kAnimationDuration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
                self.aglineYLayout.constant = 0;
                self.theLabel.alpha = 1.f;
                [self layoutIfNeeded];
                
                //Change Text
                _curIndex++;
                if (_curIndex >= self.notiStrings.count ) {
                    _curIndex = 0;
                }
                self.theLabel.text = self.notiStrings[_curIndex];
                
            } completion:^(BOOL Bfinished) {
                if (Bfinished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [self performSelector:_cmd withObject:nil];
#pragma clang diagnostic pop
                }
            }];
        }
    }];
}

- (void)startFlow
{
    
    //Animate  With Transform
//    [self animateTransForm];

    
    //Animate the Constraits
    [self animateLayout];
}

- (void)reset
{
    self.theLabel.alpha = 1.f;
    self.theLabel.text = self.notiStrings[_curIndex];
    
    if (self.aglineYLayout && self.aglineYLayout.constant != 0) {
        self.aglineYLayout.constant = 0;
    }
    
    if (CGAffineTransformIsIdentity(self.theLabel.transform)) {
        self.theLabel.transform = CGAffineTransformIdentity;
    }
    
}


- (void)resetAndStartFlow
{
    [self reset];
    
    //if not so,  everything goses white for several secs
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startFlow];
    });
}


@end
