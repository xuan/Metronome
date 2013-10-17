//
//  DialView.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "DialView.h"

@implementation DialView

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
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(110.81, 35.81)];
    [bezierPath addCurveToPoint: CGPointMake(110.81, 54.19) controlPoint1: CGPointMake(105.73, 40.88) controlPoint2: CGPointMake(105.73, 49.12)];
    [bezierPath addCurveToPoint: CGPointMake(129.19, 54.19) controlPoint1: CGPointMake(115.88, 59.27) controlPoint2: CGPointMake(124.12, 59.27)];
    [bezierPath addCurveToPoint: CGPointMake(129.19, 35.81) controlPoint1: CGPointMake(134.27, 49.12) controlPoint2: CGPointMake(134.27, 40.88)];
    [bezierPath addCurveToPoint: CGPointMake(110.81, 35.81) controlPoint1: CGPointMake(124.12, 30.73) controlPoint2: CGPointMake(115.88, 30.73)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(202.02, 37.98)];
    [bezierPath addCurveToPoint: CGPointMake(202.02, 202.02) controlPoint1: CGPointMake(247.33, 83.28) controlPoint2: CGPointMake(247.33, 156.72)];
    [bezierPath addCurveToPoint: CGPointMake(37.98, 202.02) controlPoint1: CGPointMake(156.72, 247.33) controlPoint2: CGPointMake(83.28, 247.33)];
    [bezierPath addCurveToPoint: CGPointMake(37.98, 37.98) controlPoint1: CGPointMake(-7.33, 156.72) controlPoint2: CGPointMake(-7.33, 83.28)];
    [bezierPath addCurveToPoint: CGPointMake(202.02, 37.98) controlPoint1: CGPointMake(83.28, -7.33) controlPoint2: CGPointMake(156.72, -7.33)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
}

@end
