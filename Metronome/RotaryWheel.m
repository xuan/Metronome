//
//  RotaryWheel.m
//  Dial
//
//  Created by Xuan Nguyen on 10/21/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "RotaryWheel.h"
#import "DialView.h"

@interface RotaryWheel()

@end

UIButton *tapButton;
static float deltaAngle;
float cumulatedValue = 40;
double lastTapped = 0;

@implementation RotaryWheel

@synthesize container, startTransform;

- (id)init {
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
        [self drawWheel];
        [self drawTapButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        [self drawWheel];
        [self drawTapButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andDelegate:(id)del {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = del;
        [self drawWheel];
        [self drawTapButton];
    }
    return self;
}

- (void)drawWheel {
    self.container = [[UIView alloc] initWithFrame:self.frame];
    DialView *dialView = [[DialView alloc]initWithFrame:self.bounds];
    
    [container addSubview:dialView];
    
    container.userInteractionEnabled = NO;
    [self addSubview:container];
}

- (void)drawTapButton {
    
    CAShapeLayer *tapLayer = [CAShapeLayer layer];
    [tapLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* tapButtonPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 150, 150)];
    [tapLayer setPath:tapButtonPath.CGPath];
    [tapLayer setLineWidth:2];
    [tapLayer setStrokeColor:[UIColor blueColor].CGColor];
    [tapLayer setBackgroundColor:[UIColor clearColor].CGColor];
    
    tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tapButton.frame = CGRectMake(0,0,150,150);
    tapButton.center = self.center;
    [tapButton setBackgroundColor:[UIColor clearColor]];
    [tapButton.layer addSublayer:tapLayer];
    
    [tapButton addTarget:self action:@selector(tapButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:tapButton];
}

#pragma mark - Touch Controls

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPoint];
    
    if (dist < 100 || dist > 150) {
        return  NO;
    }
    float dx = touchPoint.x - container.center.x;
    float dy = touchPoint.y - container.center.y;
    deltaAngle = atan2(dy, dx);
    startTransform = container.transform;
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint pt = [touch locationInView:self];
    CGPoint previousPt = [touch previousLocationInView:self];
    float dist = [self calculateDistanceFromCenter:pt];
    
    if (dist < 100) {
        return NO;
    }
    
    float dx = pt.x - container.center.x;
    float dy = pt.y - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    
    //figure out angle of just-previous touch during movement
    float preDx = previousPt.x - container.center.x;
    float preDy = previousPt.y - container.center.y;
    float preAng = atan2(preDy, preDx);
    
    if (fabsf(ang-preAng) < 1) {
        if (ang > preAng) {
            if (ang - preAng < 0.05) {
                [self addValue:0.1];
            }
            if (ang - preAng > 0.05 && ang - preAng < 0.2) {
                [self addValue:5.0];
            }
            if (ang - preAng > 0.2) {
                [self addValue:10.0];
            }
        }
        if (ang < preAng) {
            if (preAng - ang < 0.05) {
                [self subValue:0.1];
            }
            if (preAng - ang > 0.05 && preAng - ang < 0.2) {
                if (cumulatedValue > 5) {
                    [self subValue:5.0];;
                }else {
                    [self subValue:1.0];
                }
            }
            if (preAng - ang > 0.2) {
                if (cumulatedValue > 10) {
                    [self subValue:10.0];
                }else {
                    [self subValue:1.0];
                }
            }
        }
    }
    
    return YES;
}

#pragma mark - Helper Functions

- (float)calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void)addValue:(float)value{
    if(cumulatedValue < 400) {
        cumulatedValue = cumulatedValue + value;
        [[self delegate]wheelDidChangeValue:cumulatedValue];
    }
}

- (void)subValue:(float)value{
    if(cumulatedValue > 40) {
        cumulatedValue = cumulatedValue - value;
        [[self delegate]wheelDidChangeValue:cumulatedValue];
    }
}

- (void)tapButtonPressed {
    if (lastTapped == 0) {
        lastTapped = CACurrentMediaTime();
    } else {
        //BPM in seconds = 60,000 / ms
        double now = CACurrentMediaTime();
        double seconds = now - lastTapped;
        double milliSecondsPartOfCurrentSecond = seconds - (int)seconds;
        double wholeMilliSeconds = (milliSecondsPartOfCurrentSecond * 1000.0);
        
        cumulatedValue = 60000/wholeMilliSeconds;
        [[self delegate]wheelDidChangeValue:cumulatedValue];
        
        lastTapped = now;
    }
}

@end
