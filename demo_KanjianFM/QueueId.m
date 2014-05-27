//
//  QueueId.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "QueueId.h"

@implementation QueueId

- (id)initWithUrl:(NSURL *)url andCount:(int)count {
    if ((self = [super init])) {
        self.url = url;
        self.count = count;
    }
    return self;
}

@end
