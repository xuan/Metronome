//
//  ViewController.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetronomePlayer.h"
#import "BeatsPerMinuteProtocol.h"

@interface ViewController : UIViewController <BeatsPerMinuteProtocol, MetronomePlayerDelegate>

@end
