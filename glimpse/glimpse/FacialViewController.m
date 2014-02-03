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
    NSMutableDictionary *_contactDictionary;
    ContactGrabber *_contractGrabber;
    FaceDetector *_faceDetector;
}
@end

@implementation FacialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Finder";
    _contactDictionary = [[NSMutableDictionary alloc]init];
    [_contactDictionary setObject:self.personsName forKey:@"Name"];
    [_contactDictionary setObject:self.personsPhone forKey:@"Phone Number"];
    [_contactDictionary setObject:self.personsHomeTown forKey:@"HomeTown"];
    [_contactDictionary setObject:self.personsHobbies forKey:@"Hobbies"];
    [_contactDictionary setObject:self.personsEducation forKey:@"Education"];
    [_contactDictionary setObject:self.personsAge forKey:@"Age"];
    [_contactDictionary setObject:self.personsWork forKey:@"Work"];
    [_contactDictionary setObject:self.personsEmail forKey:@"Email"];
    [_contactDictionary setObject:self.personsCurrent forKey:@"CurrentTown"];

    //Create the contract grabber that will get the person's contact
    _contractGrabber = [[ContactGrabber alloc]initWithDictionary:_contactDictionary];
    _contractGrabber.delegate = self;
    
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    //Create the facedetector that enables the video tracking session
    _faceDetector = [[FaceDetector alloc]init];
    _faceDetector.fullName = self.personsName;
    _faceDetector.jobTitle = self.personsWork;
    _faceDetector.delegate = self;
    _faceDetector.previewView = self.view;
    [_faceDetector setupVideoFaceDetection];
}

-(IBAction)getPersonContact:(id)sender
{
    [_contractGrabber getPersonContact];
}

#pragma mark - FaceDetector Protocol
-(void)moveContactsButton:(CGRect)markerFrame
{
    [self.getContactsBtn setFrame:markerFrame];
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
    [self dismissViewControllerAnimated:NO completion:^
    {
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    //Remove the video session otherwise this will cause a huge memory leak and
    //will crash
    [_faceDetector teardownVideoFaceDetection];
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
    
    //UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.get snapToPoint:point];
    //[self.animator addBehavior:snapBehavior];
    
    self.snapBehavior = snapBehavior;
    
    //self.getContactsBtn.center = CGPointMake(self.marker.center.x, self.marker.center.y);
}


@end