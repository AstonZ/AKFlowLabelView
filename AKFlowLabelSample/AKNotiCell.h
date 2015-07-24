//
//  AKNotiCell.h
//  AKFlowLabelSample
//
//  Created by Aston K Mac on 15/7/22.
//  Copyright (c) 2015年 Aston K Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKFlowLabel.h"

@interface AKNotiCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@property (weak, nonatomic) IBOutlet AKFlowLabel *flowLabel;


/** callback when tap on the label **/
@property (nonatomic, copy) void(^blockTapOnFlowLabel)(NSInteger index, NSString *notiString);


@end
