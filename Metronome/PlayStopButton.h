//
//  OnOffButton.h
//  Metronome
//
//  Created by Xuan Nguyen on 10/31/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayStopButton : UIButton
-(void)changePlayState:(BOOL) play;
-(BOOL)isPlaying;
@end
