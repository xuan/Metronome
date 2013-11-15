//
//  MetronomePlayer.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "MetronomePlayer.h"
#import "AudioSamplePlayer.h"
#import "MetronomeConstants.h"

#define WHOLE_NOTE(note)    ((60.0 / note) * 4)
#define HALF_NOTE(note)     ((60.0 / note) * 2)
#define QUARTER_NOTE(note)  (60.0 / note)
#define EIGHTH_NOTE(note)   ((60.0 / note) / 2)
#define SIXTEEN_NOTE(note)   ((60.0 / note) / 4)

@interface MetronomePlayer ()

@property int currentBeat;
@property BOOL isPlaying;
@property NSString *audio;
@property (weak) id <MetronomePlayerDelegate> delegate;

@end

@implementation MetronomePlayer {
    
}

- (id)init {
    self = [super init];
    if (self) {
        [self setAudio:@"tick"];
        [[AudioSamplePlayer sharedInstance] preloadAudioSample:[self audio]];
        [self setBottomSignature:[NSNumber numberWithInt:DEFAULT_BOTTOM_SIGNAUTRE]];
        [self setTempo:[NSNumber numberWithInt:DEFAULT_BPM_ON_STARTUP]];
    }
    return self;
}

- (id)initWithAudio:(NSString*)audio topSignature:(NSNumber*)top bottomSignature:(NSNumber*)bottom beatsPerMinute:(NSNumber*)bpmInterval andDelegate:(id)del {
    self = [super init];
    if (self) {
        [self setDelegate:del];
        [self setAudio:audio];
        [[AudioSamplePlayer sharedInstance] preloadAudioSample:audio];
        [self setTopSignature:top];
        [self setBottomSignature:bottom];
        [self setTempo:bpmInterval];
    }
    return self;
}

- (void)startMetronome {
    /* Check to see if we are already playing */
    if (![self isPlaying]) {
        
        /* The metronome is a loop that runs until it is cancelled.
         So that it does not interfere with the user interface, it
         should be run on a seperate queue.
         */
        dispatch_queue_t metronomeQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(metronomeQueue, ^{
            /* Set the continuePlaying flag to YES.
             Reset beatNumber to 1.
             Run the metronome loop.
             */
            [self setIsPlaying:YES];
            [self setCurrentBeat:1];
            [self playMetronome];
        });
    }
}

- (void)stopMetronome {
    /* Set the continuePlaying flag to NO.
     Reset the beatNumberLabel text.
     */
    [self setIsPlaying:NO];
}

- (void) playMetronome {
    /* We will continue looping until we are asked to stop */
    while ([self isPlaying]) {
        /* The first beat is accented.
         Subsequent beats are played at a lower gain
         with a different pitch.
         */
        if (self.currentBeat == 1) {
            [[AudioSamplePlayer sharedInstance] playAudioSample:[self audio] gain:1.0f pitch:1.0f];
            [self sendTick];
        }
        else {
            [[AudioSamplePlayer sharedInstance] playAudioSample:[self audio] gain:0.8f pitch:0.5f];
            [self sendTick];
        }
        
        /* Increment the beatNumber each time we loop.
         Note, this example has been built using a 4/4
         time signature. After the 4th beat is played,
         beatNumber must return to the first beat.
         */
        self.currentBeat++;
        if ([self currentBeat] > [[self topSignature]intValue]) {
            [self setCurrentBeat:1];
        }
        
        /* We need to monitor the time of the last beat so that we can determine
         when to play the next beat. We also need to check if the loop has
         been cancelled.
         */
        NSDate *curtainTime = [NSDate dateWithTimeIntervalSinceNow:[self getNote]];
        NSDate *currentTime = [NSDate date];
        while ([self isPlaying] && ([currentTime compare:curtainTime] != NSOrderedDescending)) {
            [NSThread sleepForTimeInterval:0.01];
            currentTime = [NSDate date];
        }
    }
}

-(double)getNote {
    double tempoInDouble = [[self tempo]doubleValue];
    if([[self bottomSignature]intValue] == 1){
        return WHOLE_NOTE(tempoInDouble);
    } else if([[self bottomSignature]intValue] == 2){
        return HALF_NOTE(tempoInDouble);
    } else if([[self bottomSignature]intValue] == 3){
        return QUARTER_NOTE(tempoInDouble);
    } else if([[self bottomSignature]intValue] == 4){
        return EIGHTH_NOTE(tempoInDouble);
    } else {
        return SIXTEEN_NOTE(tempoInDouble);
    }
}

-(void)sendTick {
    if([self delegate] != nil) {
        //send the delegate function with the amount entered by the user
        [[self delegate]tickSoundHasPlayed:[NSNumber numberWithInt:[self currentBeat]]];
    }
}
@end
