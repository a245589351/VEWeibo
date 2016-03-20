//
//  Account.h
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *uid;
@end
