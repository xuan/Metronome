//
//  MetronomePlayer.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

@protocol MetronomePlayerDelegate
@optional
-(void)tickSoundHasPlayed:(NSNumber*)tick;
@end

@interface MetronomePlayer : NSObject

@property NSNumber *tempo;
@property NSNumber *topSignature;
@property NSNumber *bottomSignature;

- (id)initWithAudio:(NSString*)audio topSignature:(NSNumber*)top bottomSignature:(NSNumber*)bottom beatsPerMinute:(NSNumber*)bpmInterval andDelegate:(id)del;

- (void)startMetronome;
- (void)stopMetronome;

@end
