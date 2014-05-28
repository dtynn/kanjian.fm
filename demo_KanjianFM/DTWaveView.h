//
//  DTWaveView.h
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-28.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTWaveView : UIView

@property (strong, nonatomic) NSMutableArray *ratios;

- (void)reDraw;

@end