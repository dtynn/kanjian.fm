//
//  QueueId.h
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueueId : NSObject

@property (assign, nonatomic) int count;
@property (copy, nonatomic) NSURL *url;

- (id)initWithUrl:(NSURL *)url andCount:(int)count;

@end
