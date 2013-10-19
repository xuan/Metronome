//
//  ViewController.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "RotaryViewController.h"
#import "MetronomePlayer.h"
#import "BeatButton.h"

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
    self.metronomePlayer = [[MetronomePlayer alloc]initWithAudio:@"tick" :[NSNumber numberWithInt:4] :[NSNumber numberWithInt:40]];
    
    self.metronomePlayer.delegate = self;
    
    
    [[self oneBtn]on];
    [[self twoBtn]off];
    [[self threeBtn]off];
    [[self fourBtn]off];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check the segue identifier
    if ([[segue identifier] isEqualToString:@"rotarySegue"])
    {
        //register the delegate to receive rotaryValue and setUIColor changes
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)oneBtnAction:(id)sender {
}

- (IBAction)twoBtnAction:(id)sender {
}

- (IBAction)threeBtnAction:(id)sender {
}

- (IBAction)fourBtnAction:(id)sender {
}

-(void)rotaryValue:(NSNumber*)val {
    //make sure that it does not go under 40 or over 300 range
    if([val intValue] < 40) {
        [[self metronomePlayer]setBpmInterval:[NSNumber numberWithInt:40]];
        [[self bpmLabel] setText:@"40"];
    } else if([val intValue] > 300) {
        [[self metronomePlayer]setBpmInterval:[NSNumber numberWithInt:300]];
        [[self bpmLabel] setText:@"40"];
    } else {
        [[self metronomePlayer]setBpmInterval:val];
        [[self bpmLabel] setText:[val stringValue]];
    }
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

