//
//  MMViewController.m
//  Knob
//
//  Created by Ryan Engle on 6/13/12.
//  Copyright (c) 2012 Ryan Engle. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create the background view and add it to the view hierarchy
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"knob-bg.png"]];
    bgView.contentMode = UIViewContentModeBottom;
    [self.view addSubview:bgView];
    
    // Add the knob to the background view
    knob_ = [[MMKnob alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:knob_];        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
