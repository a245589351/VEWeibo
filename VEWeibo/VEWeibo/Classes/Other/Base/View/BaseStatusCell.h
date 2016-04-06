//
//  BaseStatusCell.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseStatusCellFrame;
@interface BaseStatusCell : UITableViewCell {
    UIImageView *_retweeted; // 被添加微博的父控件
}

@property (nonatomic, strong) BaseStatusCellFrame *cellFrame;

@end
