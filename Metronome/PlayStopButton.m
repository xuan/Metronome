//
//  OnOffButton.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/31/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "PlayStopButton.h"

@interface PlayStopButton()

@property CAShapeLayer *roundLayer;
@property CAShapeLayer *stopLayer;
@property CAShapeLayer *playLayer;
@property BOOL playing;

@end

@implementation PlayStopButton {
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setPlaying:false];
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
    [self setRoundLayer:[CAShapeLayer layer]];
    [[self roundLayer] setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* roundPathPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(4, 4, 48, 48)];
    [[self roundLayer] setPath:roundPathPath.CGPath];
    [[self roundLayer] setLineWidth:2];
    [[self roundLayer] setStrokeColor:[UIColor blueColor].CGColor];
    
    [[self layer]addSublayer:[self roundLayer]];
}

-(void) drawStop {
    [self setStopLayer:[CAShapeLayer layer]];
    [[self stopLayer] setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* stopPath = [UIBezierPath bezierPathWithRect: CGRectMake(14, 14, 28, 28)];
    [[self stopLayer] setPath:stopPath.CGPath];
    [[self stopLayer] setLineWidth:2];
    [[self stopLayer] setStrokeColor:[UIColor blueColor].CGColor];
    
    [[self layer]addSublayer:[self stopLayer]];
}

-(void) drawPlay {
    [self setPlayLayer:[CAShapeLayer layer]];
    [[self playLayer] setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* playPath = [UIBezierPath bezierPath];
    [playPath moveToPoint: CGPointMake(18.5, 13.5)];
    [playPath addLineToPoint: CGPointMake(44.5, 28)];
    [playPath addLineToPoint: CGPointMake(18.5, 42.5)];
    [playPath addLineToPoint: CGPointMake(18.5, 13.5)];
    [playPath closePath];
    
    [[self playLayer] setPath:playPath.CGPath];
    [[self playLayer] setLineWidth:2];
    [[self playLayer] setStrokeColor:[UIColor blueColor].CGColor];
    [[self layer]addSublayer:[self playLayer]];
}

-(void)changePlayState:(BOOL) play {
    [self setPlaying:play];
    if(play){
        [[self playLayer] setOpacity:0.0];
        [[self stopLayer] setOpacity:1.0];
    } else {
        [[self playLayer] setOpacity:1.0];
        [[self stopLayer] setOpacity:0.0];
    }
}

-(BOOL)isPlaying {
    return [self playing];
}

@end
