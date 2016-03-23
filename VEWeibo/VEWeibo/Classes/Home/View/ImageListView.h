//
//  ImageListView.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//  配图列表（1～9张）

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

// 所有配图的Url
@property (nonatomic, strong) NSArray *imageUrls;

+ (CGSize)imageListSizeWithCuont:(NSInteger)count;

@end
