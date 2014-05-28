//
//  SongItem.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "SongItem.h"

@implementation SongItem

- (id)initWithAttrs:(NSDictionary *)attrs {
    if ((self = [super init])) {
        self.title = [attrs valueForKeyPath:@"title"];
        self.url = [attrs valueForKeyPath:@"url"];
    }
    return self;
}

@end
