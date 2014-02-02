//
//  FirstViewController.h
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeTownTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentTownTextField;
@property (weak, nonatomic) IBOutlet UITextField *educationTextField;
@property (weak, nonatomic) IBOutlet UITextField *workTextField;
@property (weak, nonatomic) IBOutlet UITextField *hobbiesTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

-(IBAction)saveProfileInformation:(id)sender;

@end
