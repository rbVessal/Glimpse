//
//  ContactGrabber.h
//  glimpse
//
//  Created by Rebecca Vessal on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@protocol ContactGrabberDelegate <NSObject>

@required
-(void)showContacts;
@end

@interface ContactGrabber : NSObject

@property (nonatomic, weak) id <ContactGrabberDelegate> delegate;


- (void)getPersonContact;


@end
