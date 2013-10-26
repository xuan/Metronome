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


@interface ViewController ()
@property (weak, nonatomic) IBOutlet BeatButton *oneBtn;
@property (weak, nonatomic) IBOutlet BeatButton *twoBtn;
@property (weak, nonatomic) IBOutlet BeatButton *threeBtn;
@property (weak, nonatomic) IBOutlet BeatButton *fourBtn;

@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property MetronomePlayer *metronomePlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.metronomePlayer = [[MetronomePlayer alloc]initWithAudio:@"tick2" :[NSNumber numberWithInt:4] :[NSNumber numberWithInt:40] andDelegate:self];
    RotaryWheel *wheel = [[RotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 300, 300) andDelegate:self];
    [self.view addSubview:wheel];
}

- (void) wheelDidChangeValue:(float)newValue {
    int roundVal = (int) (newValue + 0.5);
    [[self metronomePlayer]setBpmInterval:[NSNumber numberWithFloat:roundVal]];
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



-(void)setUIColor:(UIColor*)color
{
    [[self bpmLabel]setTextColor:color];
    [[self oneBtn]setColor:color];
    [[self twoBtn]setColor:color];
    [[self threeBtn]setColor:color];
    [[self fourBtn]setColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startClicked:(id)sender {
    if([[[[self startBtn]titleLabel]text] isEqual:@"start"]) {
        [[self startBtn] setTitle:@"stop" forState:UIControlStateNormal];
        [[self metronomePlayer]startMetronome];
    }else {
        [[self startBtn] setTitle:@"start" forState:UIControlStateNormal];
        [[self metronomePlayer] stopMetronome];
    }
}

-(void)tickInterval:(NSNumber*)tick {
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

