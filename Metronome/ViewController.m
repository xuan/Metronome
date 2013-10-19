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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property MetronomePlayer *metronomePlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.metronomePlayer = [[MetronomePlayer alloc]initWithAudio:@"tick" :[NSNumber numberWithInt:3] :[NSNumber numberWithInt:40]];
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



@end

