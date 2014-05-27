//
//  DataModel.h
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Playlist;
@class SongItem;

@interface DataModel : NSObject

@property (nonatomic, strong) Playlist *playlist;
@property (nonatomic, assign) NSInteger playingIndex;

- (NSInteger) numberOfSongsInPlaylist;
- (SongItem *) selectSongInPlaylistAtIndex:(NSInteger)index;

@end
