//
//  ImagePickerViewController.h
//  glimpse
//
//  Created by Student on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate >
{
	UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
    UIButton * confirmBtn;
    
    UIViewController *ProfileViewController;
}

@property (nonatomic, weak) IBOutlet UIImageView * imageView;
@property (nonatomic, weak) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, weak) IBOutlet UIButton * takePhotoBtn;
@property (nonatomic, weak) IBOutlet UIButton * confirmBtn;

-(IBAction) getPhoto:(id) sender;
-(IBAction)dismissView:(id)sender;

@end
