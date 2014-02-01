//
//  FirstViewController.m
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)saveProfileInformation:(id)sender
{
    //Save the profile information in the device
    if(![self.nameTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.nameTextField.text forKey:@"Name"];
    }
    if(![self.ageTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.ageTextField.text forKey:@"Age"];
    }
    if(![self.homeTownTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.homeTownTextField.text forKey:@"HomeTown"];
    }
    if(![self.currentTownTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.currentTownTextField.text forKey:@"CurrentTown"];
    }
    if(![self.educationTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.educationTextField.text forKey:@"Education"];
    }
    if(![self.workTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.workTextField.text forKey:@"Work"];
    }
    if(![self.hobbiesTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.hobbiesTextField.text forKey:@"Hobbies"];
    }
    if(![self.contactTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.contactTextField.text forKey:@"Contact"];
    }
    
    //Dismiss the keyboard
    [self.nameTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    [self.homeTownTextField resignFirstResponder];
    [self.homeTownTextField resignFirstResponder];
    [self.currentTownTextField resignFirstResponder];
    [self.educationTextField resignFirstResponder];
    [self.workTextField resignFirstResponder];
    [self.hobbiesTextField resignFirstResponder];
    [self.contactTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
