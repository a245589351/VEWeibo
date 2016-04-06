//
//  StatusDetailCell.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusDetailCell.h"
#import "ReweetedDock.h"
#import "StatusCellFrame.h"
#import "Status.h"
#import "Masonry.h"

@interface StatusDetailCell () {
    ReweetedDock *_dock;
}

@end

@implementation StatusDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _dock = [[ReweetedDock alloc] init];
        [_retweeted addSubview:_dock];
        [_dock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_retweeted).with.offset(0);
            make.bottom.equalTo(_retweeted).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(_dock.frame.size.width, _dock.frame.size.height));
        }];
    }
    return self;
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame {
    [super setCellFrame:cellFrame];
    
    // 设置自控件的数据
    _dock.status = cellFrame.status.retweetedStatus;
}

@end
