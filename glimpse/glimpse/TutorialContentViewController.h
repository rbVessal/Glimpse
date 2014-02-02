//
//  TutorialContentViewController.h
//  glimpse
//
//  Created by Rebecca Vessal on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end
