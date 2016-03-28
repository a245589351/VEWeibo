//
//  StatusDock.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//  一条微博底部的操作条

#import <UIKit/UIKit.h>

@class Status;
@interface StatusDock : UIImageView

@property (nonatomic, strong) Status *status;

@end
