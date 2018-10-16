//
//  ShareManage.h
//  ShareView
//
//  Created by 紫川秀 on 2018/10/16.
//  Copyright © 2018年 Woodsoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
#import "ShareModel.h"
#import "ShareViewController.h"

//分享点击事件的枚举
typedef NS_ENUM(NSInteger, ClickShareBtnType) {
    ClickShareBtnTypeWeChat         = 1,        //分享微信
    ClickShareBtnTypeWeChatZone     = 2,        //分享到微信朋友圈
    ClickShareBtnTypeQQ             = 3,        //分享到QQ
    ClickShareBtnTypeQQZone         = 4,        //分享到QQ空间
    ClickShareBtnTypeSinaWoBo       = 5,        //Sina微博
    
    ClickShareBtnTypeCacheVideo     = 11,       //离线下载
    ClickShareBtnTypeCopyConnect    = 12,       //复制链接
    ClickShareBtnTypeDing           = 13,       //顶
    ClickShareBtnTypeCai            = 14,       //踩
    ClickShareBtnTypeReport         = 15        //举报
};

//举报点击事件的枚举
typedef NS_ENUM(NSInteger, ClickReportBtnType) {
    ClickReportBtnTypeObscene                   = 0,        //淫秽色情
    ClickReportBtnTypeReactionaryPolitics       = 1,        //反动政治
    ClickReportBtnTypeAdvertisingFraud          = 2,        //广告欺诈
    ClickReportBtnTypePiracy                    = 3,        //盗版侵权
    ClickReportBtnTypeOther                     = 4         //其他
};

//顶踩
typedef NS_ENUM(NSInteger, ReportToCloundType){
    ReportToCloundTypeDing                      = 1,
    ReportToCloundTypeCai                       = 2
};

@protocol ShareManageDelegate <NSObject>

- (void) clickBtnReport: (ShareModel *)model;

@end

@interface ShareManage : NSObject


- (void) shareVideoContentToOtherPlatform: (id)Content
                     presentSnsController: (UIViewController*) customController
                        sharePlatformType: (NSInteger) platformType;

//举报按钮的响应响应事件
-(void) reportVideoToCloundWithVideoID: (NSString*)vID
                  presentSnsController: (UIViewController*) customController
                     sharePlatformType: (NSInteger) platformType;

@end
