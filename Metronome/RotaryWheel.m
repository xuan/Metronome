//
//  RotaryWheel.m
//  Dial
//
//  Created by Xuan Nguyen on 10/21/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "RotaryWheel.h"
#import "DialView.h"
#import "MetronomeConstants.h"

@interface RotaryWheel()

@property UIButton *tapButton;
@property float deltaAngle;
@property float cumulatedValue;
@property double lastTapped;

@end

@implementation RotaryWheel {
    
}

@synthesize container, startTransform;

- (id)init {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawWheel];
        [self drawTapButton];
        [self setCumulatedValue:DEFAULT_BPM_ON_STARTUP];
        [self setLastTapped:0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawWheel];
        [self drawTapButton];
        [self setCumulatedValue:DEFAULT_BPM_ON_STARTUP];
        [self setLastTapped:0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andDelegate:(id)del {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setDelegate:del];
        [self drawWheel];
        [self drawTapButton];
        [self setCumulatedValue:DEFAULT_BPM_ON_STARTUP];
        [self setLastTapped:0];
    }
    return self;
}

- (void)drawWheel {
    [self setContainer:[[UIView alloc] initWithFrame:[self frame]]];
    DialView *dialView = [[DialView alloc]initWithFrame:[self bounds]];
    [container addSubview:dialView];
    [container setUserInteractionEnabled:NO];
    [self addSubview:container];
}

- (void)drawTapButton {
    
    CAShapeLayer *tapLayer = [CAShapeLayer layer];
    [tapLayer setFillColor:[UIColor clearColor].CGColor];
    
    UIBezierPath* tapButtonPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 150, 150)];
    [tapLayer setPath:tapButtonPath.CGPath];
    [tapLayer setLineWidth:2];
    [tapLayer setStrokeColor:[UIColor grayColor].CGColor];
    [tapLayer setBackgroundColor:[UIColor clearColor].CGColor];
    
    [self setTapButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    [[self tapButton]setFrame:CGRectMake(0,0,150,150)];
    [[self tapButton]setCenter:[self center]];
    [[self tapButton]setBackgroundColor:[UIColor clearColor]];
    [[[self tapButton]layer]addSublayer:tapLayer];
    
    [[self tapButton]addTarget:self action:@selector(tapButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:[self tapButton]];
}

#pragma mark - Touch Controls

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPoint];

    if (dist < 100 || dist > 150) {
        return  NO;
    }
    float dx = touchPoint.x - [container center].x;
    float dy = touchPoint.y - [container center].y;
    [self setDeltaAngle:atan2(dy, dx)];
    startTransform = [container transform];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint pt = [touch locationInView:self];
    CGPoint previousPt = [touch previousLocationInView:self];
    float dist = [self calculateDistanceFromCenter:pt];
    
    if (dist < 100) {
        return NO;
    }
    
    float dx = pt.x - [container center].x;
    float dy = pt.y - [container center].y;
    float ang = atan2(dy,dx);
    float angleDifference = [self deltaAngle] - ang;
    
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    
    //figure out angle of just-previous touch during movement
    float preDx = previousPt.x - [container center].x;
    float preDy = previousPt.y - [container center].y;
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
                if ([self cumulatedValue] > 5) {
                    [self subValue:5.0];;
                }else {
                    [self subValue:1.0];
                }
            }
            if (preAng - ang > 0.2) {
                if ([self cumulatedValue] > 10) {
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
    CGPoint center = CGPointMake([self bounds].size.width/2, [self bounds].size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void)addValue:(float)value{
    if(self.cumulatedValue < MAX_BPM) {
        [self setCumulatedValue:[self cumulatedValue] + value];
        [[self delegate]wheelDidChangeValue:[self cumulatedValue]];
    }
}

- (void)subValue:(float)value{
    if(self.cumulatedValue > MIN_BPM) {
        [self setCumulatedValue:[self cumulatedValue] - value];
        [[self delegate]wheelDidChangeValue:[self cumulatedValue]];
    }
}

- (void)tapButtonPressed {
    
    if (self.lastTapped == 0) {
        self.lastTapped = CACurrentMediaTime();
    } else {
        //BPM in seconds = 60,000 / ms
        double now = CACurrentMediaTime();
        double seconds = now - [self lastTapped];
        double milliSecondsPartOfCurrentSecond = seconds - (int)seconds;
        double wholeMilliSeconds = (milliSecondsPartOfCurrentSecond * 1000.0);
        
        [self setCumulatedValue:60000/wholeMilliSeconds];
        [[self delegate]wheelDidChangeValue:[self cumulatedValue]];
        
        self.lastTapped = now;
    }
}

@end
