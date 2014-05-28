//
//  APIClient.h
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-28.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface APIClient : AFHTTPSessionManager

+ (instancetype) sharedClient;

@end
