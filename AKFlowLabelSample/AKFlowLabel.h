//
//  AKFlowLabel.h
//  AKFlowLabelSample
//
//  Created by Aston K Mac on 15/7/22.
//  Copyright (c) 2015年 Aston K Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKFlowLabel : UIView

/** Default Text When No Notification Data **/
@property (nonatomic, copy) NSString *defaultText;

/** Array Of Strings to Show **/
@property (nonatomic, copy) NSArray *notiStrings;

/** Start flow from given Index **/
- (void)setNotiStrings:(NSArray *)notiStrings withStartIndex:(NSInteger) index;

/** Current Showing Index **/
@property (nonatomic, assign) NSInteger curIndex;

/** Return Current Showing Index When Tapped **/
@property (nonatomic, copy) void(^blockTap)(AKFlowLabel *view, NSInteger curIndex);


/** Showing Label **/
@property (nonatomic, readonly,strong) UILabel *theLabel;


- (void)reset;

@end
