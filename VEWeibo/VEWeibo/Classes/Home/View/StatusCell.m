//
//  StatusCell.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusCell.h"
#import "StatusCellFrame.h"
#import "StatusDock.h"
#import "Masonry.h"

@interface StatusCell () {
    StatusDock *_dock;     // 微博底部操作条
}

@end

@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加操作条
        _dock = [[StatusDock alloc] init];
        [self.contentView addSubview:_dock];
        [_dock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(_dock.frame.size.width, _dock.frame.size.height));
        }];
    }
    return self;
}

- (void)setCellFrame:(BaseStatusCellFrame *)cellFrame {
    [super setCellFrame:cellFrame];
    
    // 设置dock的微博数据
    _dock.status = cellFrame.status;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y    += kTableBorderWidth;
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
}

@end
