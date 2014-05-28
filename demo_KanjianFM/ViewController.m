//
//  ViewController.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "SongItem.h"
#import "STKAudioPlayer.h"


@interface ViewController ()

@end

@implementation ViewController {
    STKAudioPlayer *_audioPlayer;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.logoViewer.image = [UIImage imageNamed:@"kanjianfm"];
    [self loadAudioPlayer];
}

- (void)reload:(id)sender {
    [self.dataModel loadSongs:^(NSError *error) {
        if (!error) {
            NSLog(@"do reload");
            [self.tableView reloadData];
        } else {
            NSLog(@"error!");
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self reload:nil];
    [self setupTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAudioPlayer {
    _audioPlayer = [self.delegate getAudioPlayer];
    _audioPlayer.delegate = self;
}

- (void)setupTimer {
    NSTimer *timer =[NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)tick {
    if (!_audioPlayer) {
        self.slider.value = 0;
        return;
    }
    if (_audioPlayer.duration != 0) {
        [self configureSliderWithMin:0 andMax:_audioPlayer.duration andValue:_audioPlayer.progress];
    } else {
        [self configureSliderWithMin:0 andMax:0 andValue:0];
    }
}

- (void)updatePlayerState {
    if (!_audioPlayer) {
        return;
    }
    if (_audioPlayer.state == STKAudioPlayerStateStopped) {
        NSLog(@"### STOPED ###");
        self.dataModel.playingIndex = -1;
        [self.tableView reloadData];
    } else if (_audioPlayer.state == STKAudioPlayerStateBuffering) {
        NSLog(@"### BUFFERING ###");
    } else if (_audioPlayer.state == STKAudioPlayerStateReady) {
        NSLog(@"### READY ###");
    }
}

- (void)configureSliderWithMin:(double)min andMax:(double)max andValue:(double)value {
    self.slider.minimumValue = min;
    self.slider.maximumValue = max;
    self.slider.value = value;
}

- (IBAction)sliderChanged:(id)sender {
    if (!_audioPlayer) {
        return;
    }
    [_audioPlayer seekToTime:self.slider.value];
}

//table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel numberOfSongsInPlaylist];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPlaylistItem"];
    SongItem *item = [self.dataModel selectSongInPlaylistAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    if (self.dataModel.playingIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataModel.playingIndex != indexPath.row) {
        SongItem *song = [self.dataModel selectSongInPlaylistAtIndex:indexPath.row];
        self.dataModel.playingIndex = indexPath.row;
        [self.tableView reloadData];
        [self.delegate audioPlayerViewPlay:self withUrl:song.url];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//audio player delegate
- (void)audioPlayer:(STKAudioPlayer *)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
    
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
    [self updatePlayerState];
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject *)queueItemId {
    
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject *)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
    
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject *)queueItemId {
    
}

@end
