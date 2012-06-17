//
//  MMKnob.h
//  Knob
//
//  Created by Ryan Engle on 6/13/12.
//  Copyright (c) 2012 Ryan Engle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MMKnob : UIView {
    
    UIImage *baseImage_;    
    UIImage *overlayImage_;
    UIImage *invertedImage_;
    
    CGFloat offset_;
    
    CGPoint center_;
    CGRect drawRect_;
    
    CMMotionManager *motionManager_;
}

@end
