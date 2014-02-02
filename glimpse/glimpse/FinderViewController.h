//
//  SecondViewController.h
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinderViewController : UIViewController 
{
    UIButton * finderButton;
}

- (IBAction)findPeople:(id)sender;
@property (nonatomic, weak) IBOutlet UIButton * finderButton;
//@property (nonatomic, weak) IBOutlet UINavigationController * transitionToFacial;


// Persons Data

@end
