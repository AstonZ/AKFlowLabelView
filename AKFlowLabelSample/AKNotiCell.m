//
//  AKNotiCell.m
//  AKFlowLabelSample
//
//  Created by Aston K Mac on 15/7/22.
//  Copyright (c) 2015年 Aston K Mac. All rights reserved.
//

#import "AKNotiCell.h"
@interface AKNotiCell()



@end


@implementation AKNotiCell


- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.flowLabel reset];
}

- (void)awakeFromNib {
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    __weak  typeof(self) wkSelf = self;
    [self.flowLabel setBlockTap:^(AKFlowLabel *flowLabel, NSInteger index) {
        if (wkSelf.blockTapOnFlowLabel) {
            wkSelf.blockTapOnFlowLabel(index,flowLabel.notiStrings[index]);
        }
    }];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
