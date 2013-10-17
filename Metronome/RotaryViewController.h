//
//  RotaryViewController.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialGestureRecognizer.h"

@protocol RotaryDelegate
@required
-(void)setBpm:(NSString*)bpm;
-(void)setUIColor:(UIColor*)color;
@end

@interface RotaryViewController : UIViewController <DialGestureRecognizerDelegate>

@end

