//
//  APIClient.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-28.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "APIClient.h"

static NSString* const APIBaseUrl = @"http://t-test-public.qiniudn.com/";

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseUrl]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
