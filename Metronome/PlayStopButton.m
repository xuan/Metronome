//
//  OnOffButton.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/31/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "PlayStopButton.h"

@implementation PlayStopButton
CAShapeLayer *roundLayer;
CAShapeLayer *stopLayer;
CAShapeLayer *playLayer;
BOOL playing = false;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    // Drawing code
    [self drawCircle];
    [self drawStop];
    [self drawPlay];
    
    [self changePlayState:NO];
}

-(void) drawCircle {
    roundLayer = [CAShapeLayer layer];
    [roundLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* roundPathPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(4, 4, 48, 48)];
    [roundLayer setPath:roundPathPath.CGPath];
    [roundLayer setLineWidth:2];
    [roundLayer setStrokeColor:[UIColor blueColor].CGColor];
    
    [[self layer]addSublayer:roundLayer];
}

-(void) drawStop {
    stopLayer = [CAShapeLayer layer];
    [stopLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* stopPath = [UIBezierPath bezierPathWithRect: CGRectMake(14, 14, 28, 28)];
    [stopLayer setPath:stopPath.CGPath];
    [stopLayer setLineWidth:2];
    [stopLayer setStrokeColor:[UIColor blueColor].CGColor];
    
    [[self layer]addSublayer:stopLayer];
}

-(void) drawPlay {
    playLayer = [CAShapeLayer layer];
    [playLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* playPath = [UIBezierPath bezierPath];
    [playPath moveToPoint: CGPointMake(18.5, 13.5)];
    [playPath addLineToPoint: CGPointMake(44.5, 28)];
    [playPath addLineToPoint: CGPointMake(18.5, 42.5)];
    [playPath addLineToPoint: CGPointMake(18.5, 13.5)];
    [playPath closePath];

    [playLayer setPath:playPath.CGPath];
    [playLayer setLineWidth:2];
    [playLayer setStrokeColor:[UIColor blueColor].CGColor];
    [[self layer]addSublayer:playLayer];
}

-(void)changePlayState:(BOOL) play {
    playing = play;
    if(play){
        [playLayer setOpacity:0.0];
        [stopLayer setOpacity:1.0];
    } else {
        [playLayer setOpacity:1.0];
        [stopLayer setOpacity:0.0];
    }
}

-(BOOL)isPlaying {
    return playing;
}

@end
