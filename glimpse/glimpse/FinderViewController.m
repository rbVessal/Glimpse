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
    ABAddressBookRef _addressBook;
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
}

-(IBAction)showPicker:(id)sender
{
    _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool accessGranted, CFErrorRef error)
     {
         if (accessGranted)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self addContactToAddressBook];
                 [self showContracts];
             });
         }
     });

}

-(void)showContracts
{
    ABPeoplePickerNavigationController *contactsController = [[ABPeoplePickerNavigationController alloc] init];
    contactsController.peoplePickerDelegate = self;
    [self presentViewController:contactsController animated:YES completion:nil];
}

//Create the contact based on the person clicked on
-(ABRecordRef)createContact
{
    CFErrorRef error;
    ABRecordRef personContactToAdd = ABPersonCreate();
    
    //Get the name and get the first and last name by separating the string by space
    NSString *fullName = [[NSUserDefaults standardUserDefaults]objectForKey:@"Name"];
    NSArray *nameComponents = [fullName componentsSeparatedByString:@" "];
    NSString *firstName = [nameComponents objectAtIndex:0];
    NSString *lastName = [nameComponents objectAtIndex:1];
    ABRecordSetValue(personContactToAdd, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName), &error);
    ABRecordSetValue(personContactToAdd, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName), &error);
    //// Adding Phone details
    // create a new phone --------------------
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, @"1-818-731-3166", kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(personContactToAdd, kABPersonPhoneProperty, multiPhone,nil);
    // release phone object
    CFRelease(multiPhone);
    
    
    ABRecordSetValue(personContactToAdd, kABPersonJobTitleProperty, (__bridge CFTypeRef)([[NSUserDefaults standardUserDefaults]objectForKey:@"Work"]), &error);
    //// Adding email details
    // create new email-ref
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, @"rebeccaVessal@gmail.com", kABWorkLabel, NULL);
    ABRecordSetValue(personContactToAdd, kABPersonEmailProperty, multiEmail, NULL);
    // release mail object
    CFRelease(multiEmail);
    //// adding address details
    // create address object
    NSString *currentTown = [[NSUserDefaults standardUserDefaults]objectForKey:@"CurrentTown"];
    NSArray *currentTownComponents = [currentTown componentsSeparatedByString:@","];
    ABMutableMultiValueRef multiAddress = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    NSMutableDictionary *addressDictionary = [[NSMutableDictionary alloc] init];
    [addressDictionary setObject:[currentTownComponents objectAtIndex:0] forKey:(NSString *)kABPersonAddressCityKey];
    [addressDictionary setObject:[currentTownComponents objectAtIndex:1] forKey:(NSString *)kABPersonAddressStateKey];
    // retain the dictionary
    CFTypeRef ctr = CFBridgingRetain(addressDictionary);
    // copy all key-values from ctr to Address object
    ABMultiValueAddValueAndLabel(multiAddress,ctr, kABHomeLabel, NULL);
    // add address object to person
    ABRecordSetValue(personContactToAdd, kABPersonAddressProperty, multiAddress, NULL);
    // release address object
    CFRelease(multiAddress);
    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [formatter setDateFormat:@"dd.MM.yyyy"];
//    NSDate *bdate=[formatter dateFromString:@"06.12.1991"]; // 10.12 is your b'date.
//    //don't set year in address book (yyyy=1604)
//    ABRecordSetValue(personContactToAdd, kABPersonBirthdayProperty, (__bridge CFTypeRef)(bdate), &error);
    NSString *hobbies = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hobbies"];
    NSString *education = [[NSUserDefaults standardUserDefaults]objectForKey:@"Education"];
    ABRecordSetValue(personContactToAdd, kABPersonNoteProperty, (__bridge CFTypeRef)([NSString stringWithFormat:@"Hobbies: %@\n Education: %@", hobbies, education]), &error);
    return personContactToAdd;

}

//Add contact to user's addressbook
- (void)addContactToAddressBook
{
    CFErrorRef error;
    ABRecordRef personContactToAdd = [self createContact];
    ABAddressBookAddRecord(_addressBook, personContactToAdd, &error);
    ABAddressBookSave(_addressBook, &error);
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// MultiPeer Connectivity

// Prepare to transfer data to another viewport
- (void) personsDataGathered {    
    [self performSegueWithIdentifier: @"transitionToFacial" sender: self];
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
@end
