//
//  FirstViewController.m
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ProfileViewController.h"
#import "ContactGrabber.h"

@interface ProfileViewController ()
{
    CGSize _keyboardSize;
    CGPoint _keyboardOrigin;
    NSMutableArray *_arrayOfTextFields;    
}

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Resize the scrollview to be bigger than the viewcontroller
    //so that scrolling is enabled
    [self.scrollview setContentSize:CGSizeMake(340, 825)];
    //Set the textfield delegates
    self.nameTextField.delegate = self;
    self.ageTextField.delegate = self;
    self.educationTextField.delegate = self;
    self.homeTownTextField.delegate = self;
    self.currentTownTextField.delegate = self;
    self.workTextField.delegate = self;
    self.hobbiesTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.phoneNumberTextField.delegate = self;
    
    //Add the next key to the keyboard
    [self.nameTextField setReturnKeyType:UIReturnKeyNext];
    [self.ageTextField setReturnKeyType:UIReturnKeyNext];
    [self.educationTextField setReturnKeyType:UIReturnKeyNext];
    [self.homeTownTextField setReturnKeyType:UIReturnKeyNext];
    [self.currentTownTextField setReturnKeyType:UIReturnKeyNext];
    [self.workTextField setReturnKeyType:UIReturnKeyNext];
    [self.hobbiesTextField setReturnKeyType:UIReturnKeyNext];
    [self.emailTextField setReturnKeyType:UIReturnKeyNext];
    [self.phoneNumberTextField setReturnKeyType:UIReturnKeyNext];
    
    //Add the textfields to an array so that the tabbing functionality can
    //be used on a mobile device
    _arrayOfTextFields = [[NSMutableArray alloc]init];
    [_arrayOfTextFields addObject:self.nameTextField];
    [_arrayOfTextFields addObject:self.ageTextField];
    [_arrayOfTextFields addObject:self.homeTownTextField];
    [_arrayOfTextFields addObject:self.currentTownTextField];
    [_arrayOfTextFields addObject:self.educationTextField];
    [_arrayOfTextFields addObject:self.workTextField];
    [_arrayOfTextFields addObject:self.hobbiesTextField];
    [_arrayOfTextFields addObject:self.emailTextField];
    [_arrayOfTextFields addObject:self.phoneNumberTextField];
    
    //Assign a tap guesture recognizer to the view to be able to dismiss
    //the keyboard when the user taps outside of the textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.tabBarController.navigationItem.title = @"Profile";
}

- (void)viewDidAppear:(BOOL)animated
{
    //If the data exists, then fill in the profile with it
    NSData *imageData = [[NSUserDefaults standardUserDefaults]objectForKey:@"Profile Picture"];
    self.profileImage.image = [UIImage imageWithData:imageData];
    self.nameTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Name"];
    self.ageTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Age"];
    self.homeTownTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"HomeTown"];
    self.currentTownTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"CurrentTown"];
    self.educationTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Education"];
    self.workTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Work"];
    self.hobbiesTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hobbies"];
    self.emailTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Email"];
    self.phoneNumberTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Phone Number"];
    
    //Change the navigation title to the profile
    self.tabBarController.navigationItem.title = @"Profile";

}

-(void)dismissKeyboard
{
    [self.nameTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
    [self.homeTownTextField resignFirstResponder];
    [self.homeTownTextField resignFirstResponder];
    [self.currentTownTextField resignFirstResponder];
    [self.educationTextField resignFirstResponder];
    [self.workTextField resignFirstResponder];
    [self.hobbiesTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    _keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _keyboardOrigin = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin;
   
}

#pragma mark - TextField delegate protocol methods
- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    //Move the scrollview so that the textfields are visible
    const float movementDuration = 0.3f; // tweak as needed
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.scrollview.contentOffset = CGPointMake(0.0, textField.frame.origin.y/2 + textField.frame.size.height );
    [UIView commitAnimations];
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
    if(![self.emailTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.emailTextField.text forKey:@"Email"];
    }
    if(![self.phoneNumberTextField.text isEqualToString:@""])
    {
        [[NSUserDefaults standardUserDefaults]setObject:self.phoneNumberTextField.text forKey:@"Phone Number"];
    }
    
    //Dismiss the keyboard
    [self dismissKeyboard];
    
    //Show confirmation of saved profile information
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Profile Saved" message:@"Your profile information was saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //Find the textfield below if there is one
    if(textField != self.phoneNumberTextField)
    {
        UITextField *nextTextField = [_arrayOfTextFields objectAtIndex:[_arrayOfTextFields indexOfObject:textField] + 1];
        [nextTextField becomeFirstResponder];
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
