//
//  ShareModel.h
//  ShareView
//
//  Created by 紫川秀 on 2018/10/16.
//  Copyright © 2018年 Woodsoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject

@property (nonatomic,copy) NSString *shareId;

@property (nonatomic,copy) NSString *imageURL;

@property (nonatomic,copy) NSString *title;

//链接
@property (nonatomic,copy) NSString *shareUrl;

@end
