//
//  ViewController.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "MetronomePlayer.h"
#import "BeatButton.h"
#import "RotaryWheel.h"
#import "PlayStopButton.h"
#import "TimeSignatureView.h"
#import "MetronomeConstants.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet BeatButton *oneBtn;
@property (weak, nonatomic) IBOutlet BeatButton *twoBtn;
@property (weak, nonatomic) IBOutlet BeatButton *threeBtn;
@property (weak, nonatomic) IBOutlet BeatButton *fourBtn;
@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;
@property (weak, nonatomic) IBOutlet PlayStopButton *startBtn;
@property MetronomePlayer *metronomePlayer;

@end

@implementation ViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setMetronomePlayer:[[MetronomePlayer alloc]initWithAudio:@"tick"
                                                      topSignature:@DEFAULT_TOP_SIGNATURE
                                                   bottomSignature:@DEFAULT_BOTTOM_SIGNAUTRE
                                                    beatsPerMinute:@DEFAULT_BPM_ON_STARTUP andDelegate:self]];
    
    UIView *rotaryContainer = [[UIView alloc]initWithFrame:CGRectMake(10, 248, 300, 300)];
    
    TimeSignatureView *ts = [[TimeSignatureView alloc]initWithFrame:CGRectMake(10, 248, 300, 300)];
    [ts setBackgroundColor:[UIColor clearColor]];
    [[self view]addSubview:ts];
    
    RotaryWheel *wheel = [[RotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 300, 300) andDelegate:self];
    [rotaryContainer addSubview:wheel];
    [self.view addSubview:rotaryContainer];
}

- (void) wheelDidChangeValue:(float)newValue {
    int roundVal = (int) (newValue + 0.5);
    [[self metronomePlayer]setTempo:[NSNumber numberWithFloat:roundVal]];
    [[self bpmLabel] setText:[NSString stringWithFormat:@"%i", roundVal]];
}

- (IBAction)oneBtnAction:(id)sender {
}

- (IBAction)twoBtnAction:(id)sender {
}

- (IBAction)threeBtnAction:(id)sender {
}

- (IBAction)fourBtnAction:(id)sender {
}



-(void)setUIColor:(UIColor*)color {
    [[self bpmLabel]setTextColor:color];
    [[self oneBtn]setChangeColor:color];
    [[self twoBtn]setChangeColor:color];
    [[self threeBtn]setChangeColor:color];
    [[self fourBtn]setChangeColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startClicked:(id)sender {
    if([[self startBtn] isPlaying]) {
        [[self startBtn] changePlayState:NO];
        [[self metronomePlayer]stopMetronome];
    }else {
        [[self startBtn] changePlayState:YES];
        [[self metronomePlayer]startMetronome];
    }
}

-(void)tickSoundHasPlayed:(NSNumber*)tick {
    if([tick intValue] == 1) {
        [[self oneBtn]on];
        [[self twoBtn]off];
        [[self threeBtn]off];
        [[self fourBtn]off];
    } else if([tick intValue] == 2) {
        [[self oneBtn]off];
        [[self twoBtn]on];
        [[self threeBtn]off];
        [[self fourBtn]off];
    } else if([tick intValue] == 3) {
        [[self oneBtn]off];
        [[self twoBtn]off];
        [[self threeBtn]on];
        [[self fourBtn]off];
    }else if([tick intValue] == 4) {
        [[self oneBtn]off];
        [[self twoBtn]off];
        [[self threeBtn]off];
        [[self fourBtn]on];
    }else{
        [[self oneBtn]on];
        [[self twoBtn]on];
        [[self threeBtn]on];
        [[self fourBtn]on];
    }
}

@end

