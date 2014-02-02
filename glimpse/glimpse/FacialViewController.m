//
//  FacialViewController.m
//  glimpse
//
//  Created by Student on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "FacialViewController.h"

@interface FacialViewController ()
{
    ContactGrabber *_contractGrabber;
}
@end

@implementation FacialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _contractGrabber = [[ContactGrabber alloc]init];
    _contractGrabber.delegate = self;
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
}

-(IBAction)getPersonContact:(id)sender
{
    [_contractGrabber getPersonContact];
}

#pragma mark - ContactGrabber Protocol
-(void)showContacts
{
    ABPeoplePickerNavigationController *contactsController = [[ABPeoplePickerNavigationController alloc] init];
    contactsController.peoplePickerDelegate = self;
    [self presentViewController:contactsController animated:YES completion:nil];
}

#pragma mark - ABPeoplePickerNavigationController Protocols
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// UIKit Dynamics

- (IBAction)handleSnapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    
    
    // Remove the previous behavior.
    [self.animator removeBehavior:self.snapBehavior];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.marker snapToPoint:point];
    [self.animator addBehavior:snapBehavior];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.get snapToPoint:point];
    [self.animator addBehavior:snapBehavior];
    
    self.snapBehavior = snapBehavior;
    
    //self.getContactsBtn.center = CGPointMake(self.marker.center.x, self.marker.center.y);
}


@end