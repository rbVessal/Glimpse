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
    
	if((UIButton *) sender == self.choosePhotoBtn)
    {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	}
    else
    {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
    
	[self presentModalViewController:picker animated:YES];
    //[self.confirmBtn setEnabled:true];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	self.imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [[NSUserDefaults standardUserDefaults]setObject:UIImagePNGRepresentation(self.imageView.image) forKey:@"Profile Picture"];
    
}

// return to profile page
-(IBAction) dismissView:(id) sender
{
    [self dismissModalViewControllerAnimated:YES];
    //ProfileViewController.view.

}


@end
