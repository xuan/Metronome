//
//  BeatsPerMinuteProtocol.h
//  Metronome
//
//  Created by Xuan Nguyen on 11/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BeatsPerMinuteProtocol <NSObject>
@required
- (void) bpmDidChangeValue:(float)newValue;
@end
