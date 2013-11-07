//
//  DialView.m
//  Dial
//
//  Created by Xuan Nguyen on 10/21/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "DialView.h"

@implementation DialView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        self.clipsToBounds = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        self.clipsToBounds = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self != nil) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        self.clipsToBounds = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int lineWidth = 20;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(lineWidth, lineWidth, self.bounds.size.height - (lineWidth*2), self.bounds.size.height - (lineWidth*2))];
    
    [circleLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:200],
      [NSNumber numberWithInt:4],nil]];
    [circleLayer setPath:circlePath.CGPath];
    [circleLayer setLineWidth:lineWidth];
    [circleLayer setStrokeColor:[UIColor blueColor].CGColor];
    
    [self.layer addSublayer:circleLayer];
    
//    CAShapeLayer *dimpleLayer = [CAShapeLayer layer];
//    UIBezierPath* dimpleStroke = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(self.bounds.size.width/2, 13, 15, 15)];
//    [dimpleLayer setPath:dimpleStroke.CGPath];
//    [dimpleLayer setFillColor:[UIColor whiteColor].CGColor];
//    [[self layer]addSublayer:dimpleLayer];
}


@end
