//
//  DialView.m
//  Dial
//
//  Created by Xuan Nguyen on 10/21/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "DialView.h"

@implementation DialView {
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

/*!
 * Default init for frame and coder
 */
-(void) initialize {
    [self setBackgroundColor:[UIColor clearColor]];
    [[self layer]setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [self setClipsToBounds:NO];
}

- (void)drawRect:(CGRect)rect
{
    int lineWidth = 20;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setFillColor:[UIColor clearColor].CGColor];
    
    CGSize boundSize = [self bounds].size;
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(lineWidth, lineWidth, boundSize.height - (lineWidth*2), boundSize.height - (lineWidth*2))];
    
    [circleLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:200],
      [NSNumber numberWithInt:4],nil]];
    [circleLayer setPath:circlePath.CGPath];
    [circleLayer setLineWidth:lineWidth];
    [circleLayer setStrokeColor:[UIColor blueColor].CGColor];
    
    [[self layer]addSublayer:circleLayer];
    
//    CAShapeLayer *dimpleLayer = [CAShapeLayer layer];
//    UIBezierPath* dimpleStroke = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(self.bounds.size.width/2, 13, 15, 15)];
//    [dimpleLayer setPath:dimpleStroke.CGPath];
//    [dimpleLayer setFillColor:[UIColor whiteColor].CGColor];
//    [[self layer]addSublayer:dimpleLayer];
}


@end
