//
//  ImageListView.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ImageListView.h"
#import "UIImageView+WebCache.h"
#import "ImageItemView.h"

#define kCount 9

#define kOneW 120
#define kOneH 120

#define kMultiW 80
#define kMultiH 80

#define kMargin 10

@implementation ImageListView

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        for (NSInteger i = 0; i < kCount; i++) {
            ImageItemView *imageView = [[ImageItemView alloc] init];
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setImageUrls:(NSArray *)imageUrls {
    _imageUrls = imageUrls;
    NSInteger count = imageUrls.count;
    for (NSInteger i = 0; i < kCount; i++) {
        // 1.取出对应位置的子控件
        ImageItemView *child = self.subviews[i];
        
        // 2.判断要不要显示图片
        if (i >= count) {
            child.hidden = YES;
            continue;
        }
        
        // 需要显示图片
        child.hidden = NO;
        
        // 3.设置图片
        child.url = imageUrls[i][@"thumbnail_pic"];
            
        // 4.设置frame
        if (count == 1) {
            child.contentMode = UIViewContentModeScaleAspectFit;
            child.frame       = CGRectMake(0, 0, kOneW, kOneH);
            continue;
        }
        
        child.clipsToBounds = YES;
        child.contentMode   = UIViewContentModeScaleAspectFill;
        NSInteger temp      = (count == 4) ? 2 : 3;
        CGFloat row         = i / temp;
        CGFloat col         = i % temp;
        CGFloat x           = (kMultiW + kMargin) * col;
        CGFloat y           = (kMultiH + kMargin) * row;
        child.frame         = CGRectMake(x, y, kMultiW, kMultiH);
    }
}

+ (CGSize)imageListSizeWithCuont:(NSInteger)count {
    if (count == 1) {
        return CGSizeMake(kOneW, kOneH);
    }
    
    NSInteger countRow = (count == 4) ? 2 : 3;
    // 总行数
    NSInteger rows = (count + countRow - 1) / countRow;
    // 总列数
    NSInteger cols = (count >= 3) ? 3 : 2;

    CGFloat width  = cols * kMultiW + (cols - 1) * kMargin;
    CGFloat height = rows * kMultiH + (rows - 1) * kMargin;
    return CGSizeMake(width, height);
}

@end
