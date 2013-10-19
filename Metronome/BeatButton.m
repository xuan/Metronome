//
//  BeatButton.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "BeatButton.h"

@interface BeatButton () {
    
@private CAShapeLayer *circleLayer;
@private UIColor *color;
    
}

@end

@implementation BeatButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.color = [UIColor blueColor];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if([super initWithCoder:aDecoder]) {
        self.color = [UIColor blueColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    circleLayer = [CAShapeLayer layer];
    
    // dialStroke Drawing
    UIBezierPath *dialStrokePath = [UIBezierPath bezierPathWithOvalInRect: rect];
    circleLayer.path = [dialStrokePath CGPath];
    [circleLayer setFillColor:[UIColor blueColor].CGColor];
    [self.layer addSublayer:circleLayer];
}

- (void) setColor:(UIColor*) colorChange {
    [circleLayer setFillColor:colorChange.CGColor];
}

-(void) on {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    circleLayer.hidden = NO;
    [CATransaction commit];
}

-(void) off {
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue
                     forKey:kCATransactionDisableActions];
    circleLayer.hidden = YES;
    [CATransaction commit];
}

@end
