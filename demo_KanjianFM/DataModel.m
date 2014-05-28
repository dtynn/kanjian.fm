//
//  DataModel.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "DataModel.h"
#import "Playlist.h"
#import "SongItem.h"
#import "APIClient.h"

@implementation DataModel

- (id)init {
    self = [super init];
    self.playlist = [[Playlist alloc] init];
    self.playingIndex = -1;
    return self;
}

- (NSInteger)numberOfSongsInPlaylist {
    return [self.playlist.songs count];
}

- (SongItem *)selectSongInPlaylistAtIndex:(NSInteger)index {
    if (index >= 0 && index < [self.playlist.songs count]) {
        return self.playlist.songs[index];
    }
    return nil;
}

- (NSURLSessionTask *)loadSongs:(void (^)(NSError *))callback {
    return [self.playlist requestForSongs:callback];
}

@end
