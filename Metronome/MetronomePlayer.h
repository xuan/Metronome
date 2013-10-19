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

@interface MetronomePlayer : NSObject<MetronomePlayerDelegate>

@property NSNumber *bpmInterval;
@property NSNumber *signature;
@property (nonatomic, assign) id <MetronomePlayerDelegate> delegate;

- (id)initWithAudio:(NSString*)audio : (NSNumber*)signature : (NSNumber*) bpmInterval;

- (void)startMetronome;
- (void)stopMetronome;

@end
