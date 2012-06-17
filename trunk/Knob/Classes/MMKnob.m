//
//  MMKnob.m
//  Knob
//
//  Created by Ryan Engle on 6/13/12.
//  Copyright (c) 2012 Ryan Engle. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MMKnob.h"

@interface MMKnob (private)

- (void)update;

@end

@implementation MMKnob

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
                
        // Load all the images for drawing
        baseImage_ = [UIImage imageNamed:@"knob-base.png"];
        overlayImage_ = [UIImage imageNamed:@"knob.png"];
        invertedImage_ = [UIImage imageNamed:@"knob-inverted.png"];
        
        // Calculate the rect where the knob images will be drawn
        drawRect_ = CGRectMake((self.frame.size.width - baseImage_.size.width)/2.0,
                               (self.frame.size.height - baseImage_.size.height)/2.0 - 12,
                               baseImage_.size.width,
                               baseImage_.size.height);
        
        // Calculate the center of the draw rect for rendering
        center_ = CGPointMake(drawRect_.origin.x + drawRect_.size.width / 2.0,
                              drawRect_.origin.y + drawRect_.size.height / 2.0);        
        
        // Create the motion manager to monitor orientation
        motionManager_ = [[CMMotionManager alloc] init];
        motionManager_.deviceMotionUpdateInterval = 1.0 / 60.0;
        [motionManager_ startDeviceMotionUpdates];
                
        // Update the view and read orientation data
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link setFrameInterval:1.0];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

// Render the knob
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    // flip orientation
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextSaveGState(context);    
            
    // Draw base layer
    CGContextSetBlendMode(context, kCGBlendModeNormal);    
    CGContextDrawImage(context, drawRect_, baseImage_.CGImage);
        
    CGContextRestoreGState(context);
    
    // Draw Inverted view
    CGContextSaveGState(context);        
        
    // Transform context
    CGContextTranslateCTM(context, center_.x, center_.y);
    CGContextRotateCTM(context, offset_);
    CGContextTranslateCTM(context, -center_.x, -center_.y);

    // Set blend mode to overlay to get the desired effect
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGContextDrawImage(context, drawRect_, invertedImage_.CGImage);
        
    CGContextRestoreGState(context);
    
    // Draw overlay image
    CGContextSaveGState(context);
    
    // Transform context
    CGContextTranslateCTM(context, center_.x, center_.y);
    CGContextRotateCTM(context, -offset_*0.7);
    CGContextTranslateCTM(context, -center_.x, -center_.y);
    
    // Draw final overlay
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGContextDrawImage(context, drawRect_, overlayImage_.CGImage);
    
    CGContextRestoreGState(context);
}

// Update the knob based on input from the device motion
- (void)update {
    
    // Create the offset based on the yaw, pitch and roll of the device
    float newOffset =   (motionManager_.deviceMotion.attitude.roll +
                         motionManager_.deviceMotion.attitude.yaw +
                         motionManager_.deviceMotion.attitude.pitch);
    
    // Set the offset to the new offset, plus a division by two and addition of one
    offset_ = newOffset / 2.0 + 1.0;    
    
    // Redraw the view
    [self setNeedsDisplay];
}


@end
