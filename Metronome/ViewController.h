//
//  ViewController.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetronomePlayer.h"
#import "RotaryWheel.h"

@interface ViewController : UIViewController <RotaryWheelProtocol,MetronomePlayerDelegate>

@end
