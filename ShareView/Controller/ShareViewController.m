//
//  ShareViewController.m
//  ShareView
//
//  Created by 紫川秀 on 2018/10/16.
//  Copyright © 2018年 Woodsoo. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareModel.h"
#import "ActionSheetView.h"
#import "ShareManage.h"

@interface ShareViewController ()

//分享操作类
@property (nonatomic, strong) ShareManage *shareManage;

@property (nonatomic, strong) ShareModel *shareModel;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点击分享" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    btn.titleLabel.textColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(ClickshareBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)ClickshareBtn{
    
    NSLog(@"点击分享按钮");
    
//    NSString *str1 = [NSString stringWithFormat:@"顶%@",_shareModel.upNum];
//    NSString *str2 = [NSString stringWithFormat:@"踩%@",_shareModel.dwnNum];
    
    NSArray *titlearry1 = @[@"微信",@"朋友圈",@"QQ",@"QQ空间"];
    NSArray *titlearry2 = @[@"新浪微博",@"离线下载",@"复制链接",@"举报"];
    NSMutableArray* titlearr = [NSMutableArray array];
    [titlearr addObject:titlearry1];
    [titlearr addObject:titlearry2];
    
    
    NSArray *imageArr1 = @[@"logo_wechat",@"logo_friendcircle",@"logo_QQ",@"logo_QQzone"];
    NSArray *imageArr2 = @[@"logo_sina",@"more_cache_normal_icon",@"more_link_icon",@"more_jubao_icon"];
    NSMutableArray* imageArr = [NSMutableArray array];
    [imageArr addObject:imageArr1];
    [imageArr addObject:imageArr2];
    
    __weak typeof(self) weakSelf = self;
    ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"" and:ShowTypeIsScrollShareStyle andHomepageModel:self.shareModel];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%ld\n当前选中的按钮title====%@",(long)btnTag, @"不知道"/*titlearr[btnTag]*/);
    
        [weakSelf.shareManage shareVideoContentToOtherPlatform:weakSelf.shareModel presentSnsController:weakSelf sharePlatformType:btnTag];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}



@end
