//
//  OauthController.m
//  VEWeibo
//
//  Created by 陈伟义 on 16/3/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OauthController.h"
#import "Weibocfg.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "MainController.h"
#import "MBProgressHUD.h"

@interface OauthController () <UIWebViewDelegate> {
    UIWebView *_webView;
}

@end

@implementation OauthController

- (void)loadView {
    _webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.加载登录页面
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=mobile", kAuthorizeUrl, kAppKey, kRedirecteURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    // 2.设置代理
    _webView.delegate = self;
}

#pragma mark - webView的代理方法
#pragma mark - webView开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 显示指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_webView animated:YES];
    
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
}

#pragma mark - webView加载结束
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 移除指示器
    [MBProgressHUD hideHUDForView:_webView animated:YES];
}
#pragma mark - 拦截webView的请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 1.获取请求全路径
    NSString *urlStr = request.URL.absoluteString;
    // 2.查找code=的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length != 0) {
        // 跳到回调地址
        NSInteger index = range.location + range.length;
        NSString *code  = [urlStr substringFromIndex:index];
        
        // 3.获得access_token和uid
        [self getAccessToken:code];
        
        return NO;
    }
    return YES;
}

#pragma mark - 获得access_token和uid
- (void)getAccessToken:(NSString *)code {
    
    // 1.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]     = kAppKey;
    params[@"client_secret"] = kAppSecret;
    params[@"grant_type"]    = kGrantType;
    params[@"redirect_uri"]  = kRedirecteURI;
    params[@"code"]          = code;
    
    // 2.获取access_token
    [HttpTool postWithPath:kAccessTokenUrl params:params success:^(id JSON) {
        // 保存帐号信息
        Account *account = [[Account alloc] init];
        account.accessToken = JSON[@"access_token"];
        account.uid = JSON[@"uid"];
        [[AccountTool sharedAccountTool] saveAccount:account];
        
        // 回到主界面
        self.view.window.rootViewController = [[MainController alloc] init];
        
        // 清楚指示器
        [MBProgressHUD hideHUDForView:_webView animated:YES];
    } failure:^(NSError *error) {
        // 清楚指示器
        [MBProgressHUD hideHUDForView:_webView animated:YES];
    }];
}

@end
