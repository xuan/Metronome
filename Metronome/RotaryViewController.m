//
//  RotaryViewController.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "RotaryViewController.h"
#import "DialView.h"
#import "DialGestureRecognizer.h"

@interface RotaryViewController ()
{
@private CGFloat imageAngle;
@private CAShapeLayer *shapeLayer;
@private DialGestureRecognizer *gestureRecognizer;
@private UIColor *color;
@private DialView *dialView;
}

@property(nonatomic,assign)id delegate;
- (void) setupGestureRecognizer;
@end

@implementation RotaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imageAngle = 0;
    
    shapeLayer = [CAShapeLayer layer];
    
    //// dialStroke Drawing
    UIBezierPath *dialStrokePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 240, 240)];
    shapeLayer.path = [dialStrokePath CGPath];
    [shapeLayer setFillColor:[UIColor blueColor].CGColor];
    [self.view.layer addSublayer:shapeLayer];
    
    dialView = [[DialView alloc]initWithFrame:CGRectMake(0,0, 240, 240)];
    [dialView setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:dialView];
    [self setupGestureRecognizer];
}


-(void)setColor:(UIColor*) changeColor
{
    [shapeLayer setFillColor:changeColor.CGColor];
}

#pragma mark - CircularGestureRecognizerDelegate protocol

- (void) rotation: (CGFloat) angle
{
    // calculate rotation angle
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 360;
    else if (imageAngle < -360)
        imageAngle += 360;
    
    // rotate image and update text field
    dialView.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    [self updateDisplay];
}

- (void) finalAngle: (CGFloat) angle
{
    // circular gesture ended, update text field
    [self updateDisplay];
    
}

// Updates the text field with the current rotation angle.
- (void) updateDisplay
{
    NSString *text = [NSString stringWithFormat: @"%d", (int)imageAngle];
    
    float blue =(225.0 - imageAngle) * 0.01;
    float red = imageAngle/255.0;
    [self setColor:[UIColor colorWithRed:red green:0.0 blue:blue alpha:1.0]];
    
    if(_delegate != nil)
    {
        //send the delegate function with the amount entered by the user
        [_delegate setBpm:text];
        [_delegate setUIColor:[UIColor colorWithRed:red green:0.0 blue:blue alpha:1.0]];
    }
    
}

// Addes gesture recognizer to the view (or any other parent view of image. Calculates midPoint
// and radius, based on the image position and dimension.
- (void) setupGestureRecognizer
{
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(dialView.frame.origin.x + dialView.frame.size.width / 2,
                                   dialView.frame.origin.y + dialView.frame.size.height / 2);
    CGFloat outRadius = dialView.frame.size.width / 2;
    
    // outRadius / 3 is arbitrary, just choose something >> 0 to avoid strange
    // effects when touching the control near of it's center
    gestureRecognizer = [[DialGestureRecognizer alloc] initWithMidPoint: midPoint
                                                            innerRadius: outRadius / 3
                                                            outerRadius: outRadius
                                                                 target: self];
    [self.view addGestureRecognizer: gestureRecognizer];
}

@end