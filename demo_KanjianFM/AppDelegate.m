//
//  AppDelegate.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-27.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "AppDelegate.h"
#import "DataModel.h"
#import "ViewController.h"
#import "STKAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "QueueId.h"

@implementation AppDelegate {
    DataModel *_dataModel;
    STKAudioPlayer *_audioPlayer;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //data model
    _dataModel = [[DataModel alloc] init];
    ViewController *controller = (ViewController *)self.window.rootViewController;
    controller.dataModel = _dataModel;
    controller.delegate = self;
    
    //audio player
    NSError *audioError;
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    
    [avSession setCategory:AVAudioSessionCategoryPlayback error:&audioError];
    Float32 bufferLength = 0.1;
    [avSession setPreferredIOBufferDuration:bufferLength error:&audioError];
    [avSession setActive:YES error:&audioError];
    
    _audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){
        .flushQueueOnSeek = YES,
        .enableVolumeMixer = NO,
        .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000}
    }];
    _audioPlayer.meteringEnabled = YES;
    _audioPlayer.volume = 1.0;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (STKAudioPlayer *)getAudioPlayer {
    return _audioPlayer;
}

- (void)audioPlayerViewPlay:(ViewController *)controller withUrl:(NSString *)url {
    NSURL *urlToPlay = [NSURL URLWithString:url];
    STKDataSource *dataSrc = [STKAudioPlayer dataSourceFromURL:urlToPlay];
    [_audioPlayer setDataSource:dataSrc withQueueItemId:[[QueueId alloc] initWithUrl:urlToPlay andCount:0]];
}

@end
