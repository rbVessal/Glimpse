//
//  AboutViewController.m
//  glimpse
//
//  Created by Rebecca Vessal on 1/31/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.navigationItem.title = @"About";
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"About";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
