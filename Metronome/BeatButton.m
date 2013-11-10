//
//  BeatButton.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "BeatButton.h"

@interface BeatButton ()
    
@property CAShapeLayer *circleLayer;

@end

@implementation BeatButton {
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        [self setChangeColor:[UIColor blueColor]];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setChangeColor:[UIColor blueColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setCircleLayer:[CAShapeLayer layer]];
    
    // dialStroke Drawing
    UIBezierPath *dialStrokePath = [UIBezierPath bezierPathWithOvalInRect: rect];
    [[self circleLayer] setPath:[dialStrokePath CGPath]];
    [[self circleLayer] setFillColor:[UIColor blueColor].CGColor];
    [[self layer] addSublayer:[self circleLayer]];
}

- (void) setChangeColor:(UIColor*) color {
    [[self circleLayer] setFillColor:color.CGColor];
}

-(void) on {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    [[self circleLayer] setHidden:NO];
    [CATransaction commit];
}

-(void) off {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    [[self circleLayer] setHidden:YES];
    [CATransaction commit];
}

@end
