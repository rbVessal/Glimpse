//
//  FaceDetector.h
//  glimpse
//
//  Created by Rebecca Vessal on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

//Taken from FaceDetectionPOC sample code by Jereon Trappers at iCapps
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
@protocol FaceDetectorProtocol <NSObject>

@required
-(void)moveContactsButton:(CGRect)markerRect;
@end


@interface FaceDetector : NSObject <UIGestureRecognizerDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak, nonatomic) UIView *previewView;

@property (nonatomic, weak) id <FaceDetectorProtocol> delegate;


-(void)setupVideoFaceDetection;
-(void)teardownVideoFaceDetection;

@end
