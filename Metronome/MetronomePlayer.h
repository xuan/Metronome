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
@property NSNumber *numberOfBeatsPerMeasure;
@property NSNumber *timeValueOfEachBeat;

- (id)initWithAudio:(NSString*)audio numberOfBeatsPerMeasure:(NSNumber*)tvb timeValueOfEachBeat:(NSNumber*)tvb beatsPerMinute:(NSNumber*)bpmInterval andDelegate:(id)del;

- (void)startMetronome;
- (void)stopMetronome;

@end
