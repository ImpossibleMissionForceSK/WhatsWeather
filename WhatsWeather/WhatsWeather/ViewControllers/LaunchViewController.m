//
//  LaunchViewController.m
//  WhatsWeather
//
//  Created by Ryan on 2016/12/3.
//  Copyright © 2016年 HelloRyan. All rights reserved.
//

#import "LaunchViewController.h"
#import "MainViewController.h"

@interface LaunchViewController () {

    UIScrollView *_scrollView;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化视图
    [self initViews];
}

// 初始化视图
- (void)initViews {

    WS(weakSelf);
    // 获取启动图片
    UIImage *launchImg = [UIImage imageNamed:@"launchImg.png"];
    CGSize launchImgSize = CGSizeMake(launchImg.size.width / launchImg.size.height * kScreenHeight, kScreenHeight);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, launchImgSize.width, launchImgSize.height)];
    imageView.image = launchImg;

    // 创建滚动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.contentSize = launchImgSize;
    _scrollView.userInteractionEnabled = NO;
    [_scrollView addSubview:imageView];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if(_scrollView.contentOffset.x < kScreenWidth) {
            [_scrollView scrollRectToVisible:CGRectMake(_scrollView.contentOffset.x + 10, 0, kScreenWidth, kScreenHeight) animated:YES];
        }else {

            MainViewController *mainVC = [[MainViewController alloc] init];
            UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainVC];
            [self.view.window setRootViewController:mainNC];
            [timer invalidate];
        }
    }];
    
    // 创建遮盖视图
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = kRGBColor(0, 0, 0, .5);
    [self.view addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    // 创建titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"WhatsWeather";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Zapfino" size:30];
    [coverView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 40));
        make.center.equalTo(coverView);
    }];

}

// 内存管理
-(void)dealloc {
    
    NSLog(@"LaunchViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
