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

static float deltaAngle;
float cumulatedValue = 0;

@implementation RotaryWheel

@synthesize container, startTransform;


- (id)initWithFrame:(CGRect)frame andDelegate:(id)del {
    if ((self = [super initWithFrame:frame])) {
        self.delegate = del;
        [self drawWheel];
    }
    return self;
}

- (void)drawWheel {
    self.container = [[UIView alloc] initWithFrame:self.frame];
    DialView *dialView = [[DialView alloc]initWithFrame:CGRectMake(0,0, 240, 240) andColor:[UIColor redColor]];
    
    dialView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    dialView.layer.position = CGPointMake(container.bounds.size.width/2.0, container.bounds.size.height/2.0);
    dialView.clipsToBounds = NO;
    [container addSubview:dialView];
    
    container.userInteractionEnabled = NO;
    [self addSubview:container];
}

#pragma mark - Touch Controls

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPoint];
    if (dist < 30 || dist > 100) {
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
    if (dist < 30) {
        // NSLog(@"Movement cancelled, too close to center");
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
        
        // ================================================================================================================
        // This lovely block of code here is not exactly what I want, but it works (for now)
        // check the distance between the current touch point and the (just) previous touch point
        // first, make sure we aren't at the 9 o'clock position, where the 'ang' variable makes a huge jump from 0 to 2M_PI
        // Then check if the wheel is spinning clockwise or counterclockwise
        // The distance between ang and preAng determines how much we add to the currentDate timer
        // some quick and dirty fixes for subtracting 10 when the timer is less than 10
        //      (prevents looping back to 23:59:59, etc)
        // ================================================================================================================
        
        if (fabsf(ang-preAng) < 1) {
            if (ang > preAng) {
                if (ang - preAng < 0.05) {
                    [self addValue:0.1];
                    // NSLog(@"addValue:0.1");
                }
                if (ang - preAng > 0.05 && ang - preAng < 0.2) {
                    [self addValue:5.0];
                    // NSLog(@"addValue:5.0");
                }
                if (ang - preAng > 0.2) {
                    [self addValue:10.0];
                    // NSLog(@"addValue:10.0");
                }
            }
            if (ang < preAng) {
                if (preAng - ang < 0.05) {
                    [self subValue:0.1];
                    // NSLog(@"subValue:0.1");
                }
                if (preAng - ang > 0.05 && preAng - ang < 0.2) {
                    if (cumulatedValue > 5) {
                        [self subValue:5.0];
                        // NSLog(@"subValue:5.0");
                    }else {
                        [self subValue:1.0];
                        // NSLog(@"subValue:1.0(2.2)");
                    }
                }
                if (preAng - ang > 0.2) {
                    if (cumulatedValue > 10) {     // putting out fires...
                        [self subValue:10.0];
                        // NSLog(@"subValue:10.0");
                    }else {
                        [self subValue:1.0];
                        // NSLog(@"subValue:1.0(2)");
                    }
                }
            }
        }

    return YES;
    // 4/1/2012
    // add some code in here to track the number of completed rotations
    // after a certain number of successive rotations, add MORE to the clock on each turn
    // this makes adding a lot of time easier, you don't have to spin as much
    
    // should also normalize the added time somehow (one full rotation adds a minute, etc)
    // also need to fix the bug at the left side of wheel (9 o'clock) where it will add/sub weirdly
}


#pragma mark - Helper Functions

- (float)calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void)addValue:(float)value{
    cumulatedValue = cumulatedValue + value;
    [[self delegate]wheelDidChangeValue:cumulatedValue];
}

- (void)subValue:(float)value{
    cumulatedValue = cumulatedValue - value;
    [[self delegate]wheelDidChangeValue:cumulatedValue];
}
@end
