//
//  ImageItemView.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ImageItemView.h"
#import "HttpTool.h"

@interface ImageItemView () {
    UIImageView *_gifImage;
}

@end

@implementation ImageItemView

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        UIImageView *gifImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifImage];
        _gifImage = gifImage;
    }
    return self;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    
    // 1.下载图片
    [HttpTool downloadImage:url place:[UIImage imageNamed:@"timeline_image_loading"] imageView:self];
    
    // 2.判断是否为gif
    _gifImage.hidden = ![url.lowercaseString hasSuffix:@"gif"];
}

- (void)setFrame:(CGRect)frame {
    // 1.设置gifView的位置
    CGRect gifFrame   = _gifImage.frame;
    gifFrame.origin.x = frame.size.width - gifFrame.size.width;
    gifFrame.origin.y = frame.size.height - gifFrame.size.height;
    _gifImage.frame   = gifFrame;
    
    [super setFrame:frame];
}

@end
