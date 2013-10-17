//
//  ViewController.m
//  Metronome
//
//  Created by Xuan Nguyen on 10/17/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "RotaryViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Check the segue identifier
    if ([[segue identifier] isEqualToString:@"rotarySegue"])
    {
        [[segue destinationViewController] setDelegate:self];
    }
}

-(void)setBpm:(NSString*)bpm {
    [[self bpmLabel] setText:bpm];
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

@end

