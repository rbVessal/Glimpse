//
//  SecondViewController.m
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "FinderViewController.h"
#import "FacialViewController.h"

@interface FinderViewController ()
{
    
}

@property (nonatomic, strong) NSString * personsImage;
@property (nonatomic, strong) NSString * personsName;
@property (nonatomic, strong) NSString * personsAge;
@property (nonatomic, strong) NSString * personsHomeTown;
@property (nonatomic, strong) NSString * personsCurrent;
@property (nonatomic, strong) NSString * personsEducation;
@property (nonatomic, strong) NSString * personsWork;
@property (nonatomic, strong) NSString * personsHobbies;
@property (nonatomic, strong) NSString * personsPhone;
@property (nonatomic, strong) NSString * personsEmail;

@end

@implementation FinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tabBarController.navigationItem.title = @"Lobby";
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"Lobby";
}

// MultiPeer Connectivity

// Set up MultiPeer
//NSString *hobbies = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hobbies"];

// Prepare to transfer data to another viewport
- (void) personsDataGathered {    
    //[self performSegueWithIdentifier: @"transitionToFacial" sender: self];
}

// Seque is being performed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"transitionToFacial"]){
        FacialViewController *controller = (FacialViewController *)segue.destinationViewController;
        controller.personsImage = self.personsImage;
        controller.personsName = self.personsName;
        controller.personsAge = self.personsAge;
        controller.personsHomeTown = self.personsHomeTown;
        controller.personsCurrent = self.personsCurrent;
        controller.personsEducation = self.personsEducation;
        controller.personsWork = self.personsWork;
        controller.personsHobbies = self.personsHobbies;
        controller.personsPhone = self.personsPhone;
        controller.personsEmail = self.personsEmail;        
    }
}

- (IBAction)findPeople:(id)sender {
    
    self.personsName = @"NameP";
    [self personsDataGathered];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
