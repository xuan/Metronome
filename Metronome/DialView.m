//
//  DialView.m
//  Dial
//
//  Created by Xuan Nguyen on 10/21/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "DialView.h"

@implementation DialView
CAShapeLayer *bgLayer;

- (id)initWithFrame:(CGRect)frame andColor:(UIColor*) color
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.color = color;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    // draw bg layer
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    UIBezierPath *bgStrokePath = [UIBezierPath bezierPathWithOvalInRect: rect];
    bgLayer.path = [bgStrokePath CGPath];
    [bgLayer setFillColor:[UIColor blueColor].CGColor];
    [self.layer addSublayer:bgLayer];

     // draw rotary on top of bg
    CAShapeLayer *rotaryLayer = [CAShapeLayer layer];
   
    UIBezierPath* rotaryPath = [UIBezierPath bezierPath];
    [rotaryPath moveToPoint: CGPointMake(110.81, 35.81)];
    [rotaryPath addCurveToPoint: CGPointMake(110.81, 54.19) controlPoint1: CGPointMake(105.73, 40.88) controlPoint2: CGPointMake(105.73, 49.12)];
    [rotaryPath addCurveToPoint: CGPointMake(129.19, 54.19) controlPoint1: CGPointMake(115.88, 59.27) controlPoint2: CGPointMake(124.12, 59.27)];
    [rotaryPath addCurveToPoint: CGPointMake(129.19, 35.81) controlPoint1: CGPointMake(134.27, 49.12) controlPoint2: CGPointMake(134.27, 40.88)];
    [rotaryPath addCurveToPoint: CGPointMake(110.81, 35.81) controlPoint1: CGPointMake(124.12, 30.73) controlPoint2: CGPointMake(115.88, 30.73)];
    [rotaryPath closePath];
    [rotaryPath moveToPoint: CGPointMake(202.02, 37.98)];
    [rotaryPath addCurveToPoint: CGPointMake(202.02, 202.02) controlPoint1: CGPointMake(247.33, 83.28) controlPoint2: CGPointMake(247.33, 156.72)];
    [rotaryPath addCurveToPoint: CGPointMake(37.98, 202.02) controlPoint1: CGPointMake(156.72, 247.33) controlPoint2: CGPointMake(83.28, 247.33)];
    [rotaryPath addCurveToPoint: CGPointMake(37.98, 37.98) controlPoint1: CGPointMake(-7.33, 156.72) controlPoint2: CGPointMake(-7.33, 83.28)];
    [rotaryPath addCurveToPoint: CGPointMake(202.02, 37.98) controlPoint1: CGPointMake(83.28, -7.33) controlPoint2: CGPointMake(156.72, -7.33)];
    [rotaryPath closePath];
    [rotaryPath fill];
    
    rotaryLayer.path = [rotaryPath CGPath];
    [rotaryLayer setFillColor:[UIColor whiteColor].CGColor];
    
    [self.layer addSublayer:rotaryLayer];
}

-(void)setColor:(UIColor*) newColor {
    [bgLayer setFillColor:newColor.CGColor];
}

@end
