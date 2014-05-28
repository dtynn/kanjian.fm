//
//  DTWaveView.m
//  demo_KanjianFM
//
//  Created by 王麟 on 14-5-28.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "DTWaveView.h"

@implementation DTWaveView {
    CGFloat _width;
    CGFloat _height;
    NSInteger _barCount;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        _barCount = 120;
        self.ratios = [NSMutableArray arrayWithCapacity:_barCount];
        self.backgroundColor = [UIColor grayColor];
        [self reDraw];
    }
    return self;
}

- (UIView *)barWithIndex:(NSInteger)index andRatio:(CGFloat)ratio {
    CGFloat w = _width/_barCount;
    CGFloat h = _height*ratio;
    CGFloat x = w * index;
    CGFloat y = (_height - h)/2;
    CGRect frame = CGRectMake(x, y, w, h);
    UIView *bar = [[UIView alloc] initWithFrame:frame];
    return bar;
}

- (void)reDraw {
    //clean
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    //draw
    NSInteger count = [self.ratios count];
    NSInteger loc = 0;
    NSInteger len = _barCount;
    if (len == 0) {
        return;
    } else if (count < _barCount) {
        len = count;
    } else {
        loc = count - len;
    }
    NSLog(@"from %d to %d", loc, len);
    NSArray *ratiosToDraw = [self.ratios subarrayWithRange:NSMakeRange(loc, len)];
    for (NSInteger barIndex=0; barIndex<[ratiosToDraw count]; barIndex+=1) {
        CGFloat ratio = [ratiosToDraw[barIndex] floatValue];
        UIView *bar = [self barWithIndex:barIndex andRatio:ratio];
        bar.backgroundColor = [UIColor blueColor];
        [self addSubview:bar];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end