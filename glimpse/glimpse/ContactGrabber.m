//
//  ContactGrabber.m
//  glimpse
//
//  Created by Rebecca Vessal on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ContactGrabber.h"

@interface ContactGrabber ()
@property (nonatomic, assign) ABAddressBookRef addressBook;

@end

@implementation ContactGrabber

-(id)init
{
    self = [super init];
    return self;
}

- (void)getPersonContact
{
    // ABAddressBookCreateWithOptions is iOS 6 and up.
    if (&ABAddressBookCreateWithOptions)
    {
        // First time access has been granted, add the contact
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
        {
            self.addressBook = ABAddressBookCreateWithOptions(nil, NULL);
            ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool accessGranted, CFErrorRef error)
            {
                if (accessGranted)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CFErrorRef error;
                        //Create the contact, add it to the addressbook, and save it
                        ABRecordRef personContactToAdd = [self createContact];
                        ABAddressBookAddRecord(self.addressBook, personContactToAdd, &error);
                        ABAddressBookSave(self.addressBook, &error);
                        //Afterwards show the contacts to let the user see the new contact
                        [self.delegate showContacts];
                    });
                }

            });
        }
        else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
        {
            CFErrorRef error;
            //Create the contact, add it to the addressbook, and save it
            ABRecordRef personContactToAdd = [self createContact];
            ABAddressBookAddRecord(self.addressBook, personContactToAdd, &error);
            ABAddressBookSave(self.addressBook, &error);
            //Afterwards show the contacts to let the user see the new contact
            [self.delegate showContacts];

        }
        else
        {
            // The user has previously denied access
            NSLog( @"Access to address book is denied. Please change the privacy setting in the setting app");
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Access to Address Book Denied" message:@"Please change the privacy setting in the setting app" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
    }
//    if(ABAddressBookRequestAccessWithCompletion)
//    {
//        CFErrorRef error;
//        self.addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//        NSLog(@"Error: %@", error);
//        ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool accessGranted, CFErrorRef error)
//         {
//             if (accessGranted)
//             {
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     CFErrorRef error;
//                     //Create the contact, add it to the addressbook, and save it
//                     ABRecordRef personContactToAdd = [self createContact];
//                     ABAddressBookAddRecord(self.addressBook, personContactToAdd, &error);
//                     ABAddressBookSave(self.addressBook, &error);
//                     //Afterwards show the contacts to let the user see the new contact
//                     [self.delegate showContacts];
//                 });
//             }
//             if(error)
//             {
//                 NSLog(@"Error with addressbook request: %@", error);
//             }
//         });
//    }
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
        ABRecordSetValue(personContactToAdd, kABPersonFirstNameProperty, (__bridge CFTypeRef)(firstName), &error);
        if(nameComponents.count > 1)
        {
            NSString *lastName = [nameComponents objectAtIndex:1];

            ABRecordSetValue(personContactToAdd, kABPersonLastNameProperty, (__bridge CFTypeRef)(lastName), &error);
        }
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


@end
