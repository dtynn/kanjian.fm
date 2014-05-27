//
//  SongItem.h
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongItem : NSObject

@property (nonatomic, assign)NSInteger songId;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *author;
@property (nonatomic, copy)NSString *language;
@property (nonatomic, copy)NSString *style;
@property (nonatomic, copy)NSDate *pubDate;
@property (nonatomic, copy)NSString *lyrics;
@property (nonatomic, copy)NSString *url;

@end
