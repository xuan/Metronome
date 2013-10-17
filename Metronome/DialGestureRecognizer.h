//
//  DialGestureRecognizer.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@protocol DialGestureRecognizerDelegate <NSObject>
@optional
- (void) rotation: (CGFloat) angle;
- (void) finalAngle: (CGFloat) angle;
@end

@interface DialGestureRecognizer : UIGestureRecognizer
{
    CGPoint midPoint;
    CGFloat innerRadius;
    CGFloat outerRadius;
    CGFloat cumulatedAngle;
    id <DialGestureRecognizerDelegate> target;
}

- (id) initWithMidPoint: (CGPoint) midPoint
            innerRadius: (CGFloat) innerRadius
            outerRadius: (CGFloat) outerRadius
                 target: (id) target;
- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end