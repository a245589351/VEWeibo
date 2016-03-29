//
//  StatusDetailController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StatusDetailController.h"

@interface StatusDetailController ()

@end

@implementation StatusDetailController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

@end
