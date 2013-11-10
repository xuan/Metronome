//
//  TimeSignature.m
//  Metronome
//
//  Created by Xuan Nguyen on 11/5/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "TimeSignatureView.h"

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees) / 180)

@implementation TimeSignatureView {
    
}

- (void)drawRect:(CGRect)rect {
    [[self layer] addSublayer:[self drawButton:1 :44]];
    [[self layer] addSublayer:[self drawButton:46 :89]];
    [[self layer] addSublayer:[self drawButton:91 :134]];
    [[self layer] addSublayer:[self drawButton:136 :179]];
}

- (CAShapeLayer*) drawButton : (int) startAngle : (int) endAngle {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setBackgroundColor:[UIColor clearColor].CGColor];
    [circleLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
                                                              radius:150
                                                          startAngle:DEGREES_TO_RADIANS(startAngle)
                                                            endAngle:DEGREES_TO_RADIANS(endAngle)
                                                           clockwise:YES];
    [circleLayer setPath:circlePath.CGPath];
    [circleLayer setLineWidth:15];
    [circleLayer setStrokeColor:[UIColor grayColor].CGColor];
    
    return circleLayer;
}

@end