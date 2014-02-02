//
//  SecondViewController.m
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "FinderViewController.h"

@interface FinderViewController ()
{
    ABAddressBookRef _addressBook;
}

@end

@implementation FinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)getPersonContact:(id)sender
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
    if(fullName != nil)
    {
        NSArray *nameComponents = [fullName componentsSeparatedByString:@" "];
        NSString *firstName = [nameComponents objectAtIndex:0];
        NSString *lastName = [nameComponents objectAtIndex:1];
        ABRecordSetValue(personContactToAdd, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName), &error);
        ABRecordSetValue(personContactToAdd, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName), &error);
    }
    //// Adding Phone details
    // create a new phone --------------------
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults]objectForKey:@"Phone Number"];
    if(phoneNumber != nil)
    {
        ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(phoneNumber), kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(personContactToAdd, kABPersonPhoneProperty, multiPhone,nil);
        // release phone object
        CFRelease(multiPhone);
    }
    
    NSString *work = [[NSUserDefaults standardUserDefaults]objectForKey:@"Work"];
    if(work != nil)
    {
        ABRecordSetValue(personContactToAdd, kABPersonJobTitleProperty, (__bridge CFTypeRef)(work), &error);
    }
    //// Adding email details
    // create new email-ref
    NSString *email = [[NSUserDefaults standardUserDefaults]objectForKey:@"Email"];
    if(email != nil)
    {
        ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)(email), kABWorkLabel, NULL);
        ABRecordSetValue(personContactToAdd, kABPersonEmailProperty, multiEmail, NULL);
        // release mail object
        CFRelease(multiEmail);
    }
    //// adding address details
    // create address object
    NSString *currentTown = [[NSUserDefaults standardUserDefaults]objectForKey:@"CurrentTown"];
    if(currentTown != nil)
    {
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
    }
    
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [formatter setDateFormat:@"dd.MM.yyyy"];
//    NSDate *bdate=[formatter dateFromString:@"06.12.1991"]; // 10.12 is your b'date.
//    //don't set year in address book (yyyy=1604)
//    ABRecordSetValue(personContactToAdd, kABPersonBirthdayProperty, (__bridge CFTypeRef)(bdate), &error);
    NSString *hobbies = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hobbies"];
    NSString *education = [[NSUserDefaults standardUserDefaults]objectForKey:@"Education"];
    NSString *age = [[NSUserDefaults standardUserDefaults]objectForKey:@"Age"];
    if(hobbies != nil && education != nil && age != nil)
    {
        ABRecordSetValue(personContactToAdd, kABPersonNoteProperty, (__bridge CFTypeRef)([NSString stringWithFormat:@"Hobbies: %@\n Education: %@\nAge: %@", hobbies, education, age]), &error);
    }
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

@end
