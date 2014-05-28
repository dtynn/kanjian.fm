//
//  ViewController.h
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STKAudioPlayer.h"

@class DataModel;
@class ViewController;
@class SongItem;

@protocol AudioPlayerViewDelegate <NSObject>

- (STKAudioPlayer *) getAudioPlayer;
- (void) audioPlayerViewPlay:(ViewController *)controller withSong:(SongItem *)song;
- (void) audioPlayerViewDifFinishPlaying;

@end

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, STKAudioPlayerDelegate>

@property (readwrite, retain) STKAudioPlayer *audioPlayer;
@property (strong, nonatomic)DataModel *dataModel;
@property (weak, nonatomic) IBOutlet UIImageView *logoViewer;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <AudioPlayerViewDelegate> delegate;

- (IBAction)sliderChanged:(id)sender;

@end
