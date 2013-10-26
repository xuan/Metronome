//
//  RotaryWheel.h
//  Dial
//
//  Created by Xuan Nguyen on 10/21/13.
//  Copyright (c) 2013 Xuan Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RotaryWheelProtocol <NSObject>
@required
- (void) wheelDidChangeValue:(float)newValue;
@end

@interface RotaryWheel : UIControl {

}

@property (weak) id <RotaryWheelProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property CGAffineTransform startTransform;

- (id)initWithFrame:(CGRect)frame andDelegate:(id)del;

@end
