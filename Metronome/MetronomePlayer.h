//
//  MetronomePlayer.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

@protocol MetronomePlayerDelegate
@optional
-(void)tickInterval:(NSNumber*)tick;
@end

@interface MetronomePlayer : NSObject

@property NSNumber *bpmInterval;
@property NSNumber *signature;

- (id)initWithAudio:(NSString*)audio : (NSNumber*)signature : (NSNumber*) bpmInterval andDelegate:(id)del;

- (void)startMetronome;
- (void)stopMetronome;

@end
