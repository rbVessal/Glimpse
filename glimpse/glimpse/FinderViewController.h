//
//  SecondViewController.h
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@interface FinderViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
    UIButton * finderButton;
}

- (IBAction)findPeople:(id)sender;
@property (nonatomic, weak) IBOutlet UIButton * finderButton;

-(IBAction)getPersonContact:(id)sender;

// Persons Data

@end
