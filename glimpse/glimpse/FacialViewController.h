//
//  FacialViewController.h
//  glimpse
//
//  Created by Student on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ContactGrabber.h"

@interface FacialViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate, ContactGrabberDelegate>

@property (nonatomic, strong) NSString * personsImage;
@property (nonatomic, strong) NSString * personsAge;
@property (nonatomic, strong) NSString * personsName;
@property (nonatomic, strong) NSString * personsHomeTown;
@property (nonatomic, strong) NSString * personsCurrent;
@property (nonatomic, strong) NSString * personsEducation;
@property (nonatomic, strong) NSString * personsWork;
@property (nonatomic, strong) NSString * personsHobbies;
@property (nonatomic, strong) NSString * personsPhone;
@property (nonatomic, strong) NSString * personsEmail;

-(IBAction)getPersonContact:(id)sender;


@end
