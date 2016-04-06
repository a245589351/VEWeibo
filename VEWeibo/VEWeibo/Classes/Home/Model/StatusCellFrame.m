//
//  StatusCellFrame.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "ImageListView.h"

@implementation StatusCellFrame

- (void)setStatus:(Status *)status {
    [super setStatus:status];
    
    _cellHeight += kStatusDockHeight + 2;
}
@end
