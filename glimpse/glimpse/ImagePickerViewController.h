//
//  ImagePickerViewController.h
//  glimpse
//
//  Created by Student on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate > {
	UIImageView * imageView;
	UIButton * choosePhotoBtn;
	UIButton * takePhotoBtn;
}

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;

-(IBAction) getPhoto:(id) sender;

@end
