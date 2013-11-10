//
//  BeatButton.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/18/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 
 */
@interface BeatButton : UIButton

@property (nonatomic, strong) UIColor *changeColor;

-(void) on;

-(void) off;
@end
