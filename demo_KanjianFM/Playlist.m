//
//  Playlist.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "Playlist.h"
#import "SongItem.h"
#import "APIClient.h"

@implementation Playlist

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}

- (void)loadSongs {
    self.songs = [[NSMutableArray alloc] initWithCapacity:20];
    
    //fake songs
    SongItem *song;
    
    song = [[SongItem alloc] init];
    song.title = @"看见FM-03-我们很好看";
    song.url = @"http://music.kanjian.com/2014_05/119525_1400843334.mp3";
    [self.songs addObject:song];
    
    song = [[SongItem alloc] init];
    song.title = @"看见FM-02-不是忆青春";
    song.url = @"http://music.kanjian.com/2014_05/119525_1400583852.mp3";
    [self.songs addObject:song];
    
    song = [[SongItem alloc] init];
    song.title = @"看见FM-01-怪女孩VS乖女孩";
    song.url = @"http://music.kanjian.com/2014_05/119525_1400237859.mp3";
    [self.songs addObject:song];
}


- (NSURLSessionDataTask *)requestForSongs:(void (^)(NSError *))callback {
    return [[APIClient sharedClient] GET:@"/api/wanglin/fm" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON){
        NSLog(@"request success");
        NSArray *songsFromResponce = [JSON valueForKeyPath:@"songs"];
        NSMutableArray *mutableSongs = [NSMutableArray arrayWithCapacity:[songsFromResponce count]];
        for (NSDictionary *attrs in songsFromResponce) {
            SongItem *song = [[SongItem alloc] initWithAttrs:attrs];
            [mutableSongs addObject:song];
            
        }
        self.songs = mutableSongs;
        if (callback) {
            callback(nil);
        }
    } failure:^(NSURLSessionDataTask * __unused task, NSError *error){
        NSLog(@"request failure");
        if (callback) {
            callback(error);
        }
    }];
}

@end
