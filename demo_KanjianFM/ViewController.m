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
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if (_audioPlayer.state == STKAudioPlayerStatePlaying) {
                    [_audioPlayer pause];
                } else if (_audioPlayer.state == STKAudioPlayerStatePaused) {
                    [_audioPlayer resume];
                }
                break;
                
            case UIEventSubtypeRemoteControlPlay:
                if (_audioPlayer.state == STKAudioPlayerStatePaused) {
                    [_audioPlayer resume];
                }
                break;
                
            case UIEventSubtypeRemoteControlPause:
                if (_audioPlayer.state == STKAudioPlayerStatePlaying) {
                    [_audioPlayer pause];
                }
                break;
                
            default:
                break;
        }
    }
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
    if (!_audioPlayer || self.dataModel.playingIndex == -1) {
        return;
    }
    if (_audioPlayer.state == STKAudioPlayerStateStopped) {
        NSLog(@"### STOPED ###");
        [self.delegate audioPlayerViewDifFinishPlaying];
    }
    if (_audioPlayer.state != STKAudioPlayerStatePlaying && _audioPlayer.state != STKAudioPlayerStatePaused && _audioPlayer.state != STKAudioPlayerStateBuffering && _audioPlayer.state != STKAudioPlayerStateStopped) {
        return;
    }
    [self.tableView reloadData];
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

#pragma UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel numberOfSongsInPlaylist];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellPlaylistItem"];
    SongItem *item = [self.dataModel selectSongInPlaylistAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    if (self.dataModel.playingIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSLog(@"detail state");
        if (_audioPlayer.state == STKAudioPlayerStateBuffering) {
            cell.detailTextLabel.text = @"buffering";
        }else if (_audioPlayer.state == STKAudioPlayerStatePaused) {
            cell.detailTextLabel.text = @"paused";
        } else if (_audioPlayer.state == STKAudioPlayerStatePlaying) {
            cell.detailTextLabel.text = @"playing";
        } else {
            NSLog(@"no state");
            cell.detailTextLabel.text = @"";
        }
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataModel.playingIndex != indexPath.row) {
        SongItem *song = [self.dataModel selectSongInPlaylistAtIndex:indexPath.row];
        self.dataModel.playingIndex = indexPath.row;
        [self.tableView reloadData];
        [self.delegate audioPlayerViewPlay:self withSong:song];
    } else if (_audioPlayer.state == STKAudioPlayerStatePlaying) {
        [_audioPlayer pause];
    } else if (_audioPlayer.state == STKAudioPlayerStatePaused) {
        [_audioPlayer resume];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma STKAudioPlayerDelegate

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
