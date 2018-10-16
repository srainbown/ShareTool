//
//  ShareManage.m
//  ShareView
//
//  Created by 紫川秀 on 2018/10/16.
//  Copyright © 2018年 Woodsoo. All rights reserved.
//

/**分享地址host*/
#define URL_ShareHost           @"http://www.baidu.com/"

#import "ShareManage.h"
#import <UMSocialWechatHandler.h>
//#import "DBCHVideoModel.h"
//#import "DBCHReportViewController.h"举报页面
//#import "ZFDownloadManager.h"下载页面
#import <SVProgressHUD.h>

@interface ShareManage ()

@property (nonatomic, weak) UIViewController *              customViewController;

@property (nonatomic, weak) ShareModel *         contentModel;

////下载
//@property (strong, nonatomic) DBURLSessionTask *            task;
//@property (assign, nonatomic) BOOL                          isCache;

@end

@implementation ShareManage

//根据不同的按钮点击事件
- (void) shareVideoContentToOtherPlatform: (id)Content
                     presentSnsController: (UIViewController*) customController
                        sharePlatformType: (NSInteger) platformType
{
    self.customViewController = customController;
    self.contentModel = Content;
    switch (platformType) {
        case ClickShareBtnTypeWeChat:{
            [self shareToVideoToWeChat];
            break;
        }
            
        case ClickShareBtnTypeWeChatZone:{
            [self shareToWeChatFriend];
            break;
        }
            
        case ClickShareBtnTypeQQ:{
            [self shareToQQ];
            break;
        }
            
        case ClickShareBtnTypeQQZone:{
            [self shareToQQZone];
            break;
        }
            
        case ClickShareBtnTypeSinaWoBo:{
            [self shareToSinaWeiBo];
            break;
        }
            
        case ClickShareBtnTypeCopyConnect:{
            [self clickBtnCopyConnect];
            break;
        }
            
        case ClickShareBtnTypeCacheVideo:{
            [self clickBtnCacheVedio:customController];
            break;
        }
            
        case ClickShareBtnTypeDing:{
            [self clickBtnDing];
            break;
        }
        case ClickShareBtnTypeCai:{
            [self clickBtnCai];
            break;
        }
        case ClickShareBtnTypeReport:{
            [self clickBtnReport];
            break;
        }
        default:
            break;
    }
    
}


#pragma mark -- 分享到微信
- (void) shareToVideoToWeChat{
    NSLog(@"点击：分享微信");

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL = self.contentModel.imageURL;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.contentModel.title descr:@"" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [self getShareToURL];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}

#pragma mark -- 分享到微信朋友圈
-(void) shareToWeChatFriend {
    NSLog(@"点击：分享微信朋友圈");
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = self.contentModel.title;
    //创建网页内容对象
    NSString* thumbURL = self.contentModel.imageURL;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.contentModel.title descr:@"" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = [self getShareToURL];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}

#pragma mark -- 分享到QQ
- (void) shareToQQ{
    NSLog(@"点击：分享QQ");
    // NSString *targetUrl = self.contentModel.videoURL;
    NSString *targetUrl = [self getShareToURL];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = self.contentModel.title;
    //创建网页内容对象
    NSString* thumbURL = self.contentModel.imageURL;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.contentModel.title descr:@"" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = targetUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}

#pragma mark -- 分享到QQ空间
-(void) shareToQQZone{
    NSLog(@"点击：分享QQ");
    // NSString *targetUrl = self.contentModel.videoURL;
    NSString *targetUrl = [self getShareToURL];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = self.contentModel.title;
    //创建网页内容对象
    NSString* thumbURL = self.contentModel.imageURL;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.contentModel.title descr:@"" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = targetUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}
#pragma mark -- 分享到微博
- (void) shareToSinaWeiBo {
    NSLog(@"点击：分享新浪");
    
    //NSString *targetUrl = [self creatShareURLWithDic];
    //创建网页内容对象
    NSString* thumbURL = self.contentModel.imageURL;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //文本信息加上网页链接[self getShareToURL]
    messageObject.text = [self.contentModel.title stringByAppendingString: [self getShareToURL]];
    UMShareImageObject * imgObject = [UMShareImageObject shareObjectWithTitle:@""
                                                                        descr:@""
                                                                    thumImage:thumbURL];
    imgObject.shareImage = thumbURL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = imgObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:_customViewController completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}


//第二行内容
#pragma mark -- 复制链接
- (void) clickBtnCopyConnect{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.contentModel.shareUrl;
    
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark -- 离线下载
- (void) clickBtnCacheVedio:(UIViewController*)customController{
    NSLog(@"点击：离线下载到本地");
//    //没有登录直接跳出
//    if (nil == __GetUserToken) {
//        //跳转登录页面
//        DBCHLoginViewController* loginVC = [DBCHLoginViewController new];
//        [customController.navigationController pushViewController:loginVC animated:YES];
//        return;
//    }
//
//    NSArray * arryData = nil;
//    arryData = __SelectVedioModelAllForKey(KCacheDowningModel);
//    if (arryData.count > 50) {
//        [SVProgressHUD showSuccessWithStatus:@"下载任务繁重,请稍后重试"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//        return;
//    }

//    //解析字符串downloadWithUrl
//    NSString * filename = __GetFileNameWithDownLoadURL(self.contentModel.videoCacheURL);
//    DBCHVideoModel* videoModel = [[DBCHVideoModel alloc]init];
//    [videoModel initWithDic:self.contentModel];
    
//    //保存本地数据库中
//
//    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
//    [[ZFDownloadManager sharedDownloadManager] downFileUrl:self.contentModel.videoCacheURL filename:filename fileimage:nil model:videoModel];
//    // 设置最多同时下载个数（默认是3）
//    [ZFDownloadManager sharedDownloadManager].maxCount = 1;
    
}

#pragma mark -- 顶
- (void) clickBtnDing{
    NSLog(@"点击：顶操作！");
//    if (0 == [_contentModel.isUpdwn intValue]) {
//        //允许顶和踩功能
//        if (nil == __GetUserToken) {
//            //跳转到对应的登录界面
//            [SVProgressHUD showErrorWithStatus:@"用户未登录"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//        }else{
//            //上报顶功能
//            [self reportToCloundUToken:__GetUserToken upDownType:ReportToCloundTypeDing];
//        }
//
//    }else{
//        NSLog(@"已经顶踩过，不能再次操作！");
//    }
}

#pragma mark -- 踩
- (void) clickBtnCai{
    NSLog(@"点击：踩操作！");
//    if (0 == [_contentModel.isUpdwn intValue]) {
//        //允许顶和踩功能
//        if (nil == __GetUserToken) {
//            //跳转到对应的登录界面
//            [SVProgressHUD showErrorWithStatus:@"用户未登录"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//            //            [self.customViewController.navigationController pushViewController:nil animated:YES];
//        }else{
//            //上报踩功能
//            [self reportToCloundUToken:__GetUserToken upDownType:ReportToCloundTypeCai];
//        }
//
//    }else{
//        DBLog(@"已经顶踩过，不能再次操作！");
//    }
    
}

#pragma mark -- 上报服务器顶踩
-(void) reportToCloundUToken: (NSString*) utoken upDownType: (ReportToCloundType) type{
    
//    NSString * typeId = [NSString stringWithFormat:@"%ld", (long)type];
//
//    NSDictionary *dic = @{@"utoken" :utoken,
//                          @"type"   :typeId,
//                          @"vid"    :self.contentModel.vedioID,
//                          @"nonce"  :[DBCHDESTool getSixRandom],
//                          @"times"  :[DBCHDESTool getTimeString],
//                          };
//
//    NSDictionary * dicNet = __GetToCloundData(dic);
//
//    [AFNetworkTool postWithUrl:[URL_Base stringByAppendingString:URL_UpAndDown] parameters:dicNet success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        if ([@"success" isEqualToString:[responseObject objectForKey:@"message"]]) {
//            //解析数据保存
//            if (ReportToCloundTypeDing == type) {
//                [SVProgressHUD showSuccessWithStatus:@"已顶"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            }
//            if (ReportToCloundTypeCai == type) {
//                [SVProgressHUD showSuccessWithStatus:@"已踩"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
//            }
//            return ;
//        }
//
//    } fail:^{
//
//        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//
//        //        weakSelf.loginButton.enabled = YES;
//
//    }];
    
}


#pragma mark -- 举报
- (void) clickBtnReport{
    NSLog(@"点击：举报操作！");
//    DBCHReportViewController *vc = [[DBCHReportViewController alloc]init];
//
//    NSString *vidStr = [NSString stringWithFormat:@"%@",_contentModel.vedioID];
//    vc.vid = vidStr;
//
//    [self.customViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 举报按钮的响应响应事件
-(void) reportVideoToCloundWithVideoID: (NSString*)VID
                  presentSnsController: (UIViewController*) customController
                     sharePlatformType: (NSInteger) platformType{
//    //上报云端
//    NSString * typeId = [NSString stringWithFormat:@"%ld", (long)(platformType +1)];
//
//    //没有登录直接跳出
//    if (nil == __GetUserToken) {
//        //跳转登录页面
//        DBCHLoginViewController* loginVC = [DBCHLoginViewController new];
//        [customController.navigationController pushViewController:loginVC animated:YES];
//        return;
//    }
//
//    NSDictionary *dic = @{@"utoken" :__GetUserToken,
//                          @"reason" :typeId,
//                          @"vid"    :VID,
//                          @"nonce"  :[DBCHDESTool getSixRandom],
//                          @"times"  :[DBCHDESTool getTimeString],
//                          };
//
//    NSDictionary * dicNet = __GetToCloundData(dic);
//
//    [AFNetworkTool postWithUrl:[URL_Base stringByAppendingString:URL_ReportVideo] parameters:dicNet success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        if (6200  == [[responseObject objectForKey:@"code"] integerValue]) {
//            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"message"]];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//            return ;
//        }
//
//    } fail:^{
//
//        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//
//        //        weakSelf.loginButton.enabled = YES;
//
//    }];
    
}


////获取分享的url方法
//-(NSString*) creatShareURLWithDic{
//    //从数组中取出字典，把每个然后拼接成url
//    NSMutableString *URL = [NSMutableString stringWithFormat:@"https://api.dangcdn.com/haqucom/share"];
//    NSDictionary *dic = @{@"vid":self.contentModel.vedioID};
//    NSDictionary * dicNet = __GetToCloundData(dic);
//
//    //获取字典的所有keys
//    NSArray * keys = [dicNet allKeys];
//    NSArray * vaules = [dicNet allValues];
//
//    //拼接字符串
//    for (int i = 0; i < keys.count; i ++){
//        NSString *string;
//        if (i == 0){
//            //拼接时加？
//            string = [NSString stringWithFormat:@"?%@=%@", keys[i], vaules[i]];
//        }
//        else{
//            //拼接时加&
//            string = [NSString stringWithFormat:@"&%@=%@", keys[i], vaules[i]];
//        }
//        //拼接字符串
//        [URL appendString:string];
//
//    }
//    NSLog(@"字典转换的URL:%@", URL);
//    return URL;
//}

//获取分享的URL
-(NSString*) getShareToURL{
    NSString * url = [NSString stringWithFormat:@"%@%@.html", URL_ShareHost,self.contentModel.shareId];
    return url;
}


@end
