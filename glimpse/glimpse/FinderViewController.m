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
    ABRecordSetValue(personContactToAdd, kABPersonFirstNameProperty, @"Rebecca", &error);
    ABRecordSetValue(personContactToAdd, kABPersonLastNameProperty, @"Vessal", &error);
    //ABRecordSetValue(personContactToAdd, kABPersonPhoneProperty, @"818-731-3166", &error);
    //// Adding Phone details
    // create a new phone --------------------
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    // set the main phone number
    ABMultiValueAddValueAndLabel(multiPhone, @"1-818-731-3166", kABPersonPhoneMainLabel, NULL);
    // add phone details to person
    ABRecordSetValue(personContactToAdd, kABPersonPhoneProperty, multiPhone,nil);
    // release phone object
    CFRelease(multiPhone);
    ABRecordSetValue(personContactToAdd, kABPersonJobTitleProperty, @"Cocoa Developer", &error);
    //// Adding email details
    // create new email-ref
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    // set the work mail
    ABMultiValueAddValueAndLabel(multiEmail, @"rebeccaVessal@gmail.com", kABWorkLabel, NULL);
    // add the mail to person
    ABRecordSetValue(personContactToAdd, kABPersonEmailProperty, multiEmail, NULL);
    // release mail object
    CFRelease(multiEmail);
    //// adding address details
    // create address object
    ABMutableMultiValueRef multiAddress = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    // create a new dictionary
    NSMutableDictionary *addressDictionary = [[NSMutableDictionary alloc] init];
    // set the address line to new dictionary object
    [addressDictionary setObject:@"15937 Harvest St." forKey:(NSString *) kABPersonAddressStreetKey];
    // set the city to new dictionary object
    [addressDictionary setObject:@"Granada Hills" forKey:(NSString *)kABPersonAddressCityKey];
    // set the state to new dictionary object
    [addressDictionary setObject:@"California" forKey:(NSString *)kABPersonAddressStateKey];
    // set the zip/pin to new dictionary object
    [addressDictionary setObject:@"91344 " forKey:(NSString *)kABPersonAddressZIPKey];
    // retain the dictionary
    CFTypeRef ctr = CFBridgingRetain(addressDictionary);
    // copy all key-values from ctr to Address object
    ABMultiValueAddValueAndLabel(multiAddress,ctr, kABHomeLabel, NULL);
    // add address object to person
    ABRecordSetValue(personContactToAdd, kABPersonAddressProperty, multiAddress, NULL);
    // release address object
    CFRelease(multiAddress);
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSDate *bdate=[formatter dateFromString:@"06.12.1991"]; // 10.12 is your b'date.
    //don't set year in address book (yyyy=1604)
    ABRecordSetValue(personContactToAdd, kABPersonBirthdayProperty, (__bridge CFTypeRef)(bdate), &error);
    ABRecordSetValue(personContactToAdd, kABPersonNoteProperty, @"Hobbies: Playing Video Games\n Education: Video Game Design & Development BS at Rochester Institute of Technology\n Work Experience: Apple SpriteKit Intern", &error);
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
