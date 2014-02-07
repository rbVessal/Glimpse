//
//  ImagePickerViewController.m
//  glimpse
//
//  Created by Student on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()

@end

@implementation ImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Image Picker";
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.title = @"Image Picker";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//@synthesize imageView,choosePhotoBtn, takePhotoBtn;

-(IBAction) getPhoto:(id) sender
{
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	if((UIButton *) sender == self.choosePhotoBtn && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentModalViewController:picker animated:YES];
	}
    else if((UIButton*)sender == self.takePhotoBtn && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
	}
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Camera Not Supported" message:@"Camera is not supported on this device.  Please try using a newer generation device that supports this function" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
	
    //[self.confirmBtn setEnabled:true];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	self.imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [[NSUserDefaults standardUserDefaults]setObject:UIImageJPEGRepresentation(self.imageView.image, 100.0f) forKey:@"Profile Picture"];
    
}

-(IBAction)dismissView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
