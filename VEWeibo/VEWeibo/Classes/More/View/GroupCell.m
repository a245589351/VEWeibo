//
//  GroupCell.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GroupCell.h"

@interface GroupCell () {
    UIImageView *_rightArrow;
}

@end

@implementation GroupCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置cell背景
        UIImageView *bg = [[UIImageView alloc] init];
        bg.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:0.3];
        self.selectedBackgroundView = bg;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellType:(CellType)cellType {
    _cellType = cellType;
    
    if (cellType == kCellTypeArrow) {
        if (_rightArrow == nil) {
            _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
        }
        self.accessoryView = _rightArrow;
    } else if (cellType == kCellTypeLabel) {
        if (_rightLabel == nil) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0, 0, 50, 44);
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor grayColor];
            _rightLabel = label;
        }
        self.accessoryView = _rightLabel;
    } else if (cellType == kCellTypeNone) {
        self.accessoryView = nil;
    } else if (cellType == kCellTypeSwitch) {
        if (_rightSwitch == nil) {
            _rightSwitch = [[UISwitch alloc] init];
        }
        self.accessoryView = _rightSwitch;
    }
}

@end
