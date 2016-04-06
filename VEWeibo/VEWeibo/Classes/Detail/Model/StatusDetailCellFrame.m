//
//  StatusDetailFrame.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusDetailCellFrame.h"
#import "Status.h"

@implementation StatusDetailCellFrame
- (void)setStatus:(Status *)status {
    [super setStatus:status];
    
    if (status.retweetedStatus) {
        _retweetedFrame.size.height += kReweetedDockHeight;
        _cellHeight += kReweetedDockHeight;
    }
}
@end
