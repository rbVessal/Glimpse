//
//  SecondViewController.m
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "FinderViewController.h"

@interface FinderViewController ()

@end

@implementation FinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)showPicker:(id)sender
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
//    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
//    picker.peoplePickerDelegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
