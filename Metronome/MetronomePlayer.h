//
//  MetronomePlayer.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetronomePlayer : NSObject

@property NSNumber *bpmInterval;
@property NSNumber *signature;

- (id)initWithAudio:(NSString*)audio : (NSNumber*)signature : (NSNumber*) bpmInterval;

- (void)startMetronome;
- (void)stopMetronome;
@end
