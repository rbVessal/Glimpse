//
//  SecondViewController.m
//  glimpse
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "FinderViewController.h"
#import "FacialViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "APLPositionToBoundsMapping.h"

@interface FinderViewController ()<MCBrowserViewControllerDelegate, MCSessionDelegate>

// MultiPeer Connectivity
@property (nonatomic, strong) MCBrowserViewController *browserVC;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic, strong) MCSession *mySession;
@property (nonatomic, strong) MCPeerID *myPeerID;

@property (nonatomic, strong) NSString * personsImage;
@property (nonatomic, strong) NSString * personsName;
@property (nonatomic, strong) NSString * personsAge;
@property (nonatomic, strong) NSString * personsHomeTown;
@property (nonatomic, strong) NSString * personsCurrent;
@property (nonatomic, strong) NSString * personsEducation;
@property (nonatomic, strong) NSString * personsWork;
@property (nonatomic, strong) NSString * personsHobbies;
@property (nonatomic, strong) NSString * personsPhone;
@property (nonatomic, strong) NSString * personsEmail;

@property (nonatomic, strong) UIButton *browserButton;

@property (nonatomic, readwrite) CGRect button1Bounds;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation FinderViewController

int dataRecieved;
int dataSent;
bool done;

- (void)viewDidLoad
{
    dataRecieved = 0;
    dataSent = 0;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setUpUI];
    done = false;
    
    self.button1Bounds = self.finderButton.bounds;
    
    // Force the button image to scale with its bounds.
    self.finderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.finderButton.contentVerticalAlignment = UIControlContentHorizontalAlignmentFill;
}

-(void) viewDidAppear:(BOOL)animated
{
    // Data exist in Profile (Quick Check)
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"Name"] isEqualToString:@""])
    {
        if( !done )
        {
            [self setUpMultipeer];
            done = TRUE;
        }
    }
    
    // OtherWise force to goto get Profile
    else
    {
        [self performSegueWithIdentifier: @"GetProfile" sender: self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpUI{
    self.tabBarController.navigationItem.title = @"Lobby";

    //  Setup the browse button
   
    [self.finderButton addTarget:self action:@selector(showBrowserVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setUpMultipeer{
    
    //  Setup peer ID
    NSString * idName = [[[[NSUserDefaults standardUserDefaults]objectForKey:@"Name"] stringByAppendingString: @" - "]
                         stringByAppendingString:[[NSUserDefaults standardUserDefaults]objectForKey:@"Work"]];
    // Cap at 63
    if( idName.length > 63 )
    {
        idName = [idName substringToIndex:idName.length - (idName.length - 63)];
    }
    
    self.myPeerID = [[MCPeerID alloc] initWithDisplayName: idName] /*[UIDevice currentDevice].name]*/;
    
    //  Setup session
    self.mySession = [[MCSession alloc] initWithPeer:self.myPeerID];
    self.mySession.delegate = self;
    
    //  Setup BrowserViewController
    self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:@"chat" session:self.mySession];
    self.browserVC.delegate = self;
    
    //  Setup Advertiser
    self.advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat" discoveryInfo:nil session:self.mySession];
    [self.advertiser start];
}

- (void) showBrowserVC{
    [self presentViewController:self.browserVC animated:YES completion:nil];
}

- (void) dismissBrowserVC{
    [self.browserVC dismissViewControllerAnimated:YES completion:nil];
}

-(void) sendMessages
{
    for( int i = 0; i < 9; ++i )
    {
        [self sendText];
    }
    if( dataRecieved >= 9 )
    {
        [self personsDataGathered];
    }
}

- (void) sendText{
    //  Retrieve text from chat box and clear chat box
    NSString *message;
    NSString *key;
    
    switch( dataSent )
    {
        case /* Name */ 0:
        {
            key = @"Name";
            break;
        }
        case /* Age */ 1:
        {
            key = @"Age";
            break;
        }
        case /* HomeTown */ 2:
        {
            key = @"HomeTown";
            break;
        }
        case /* Current */ 3:
        {
            key = @"CurrentTown";
            break;
        }
        case /* Education */ 4:
        {
            key = @"Education";
            break;
        }
        case /* Work */ 5:
        {
            key = @"Work";
            break;
        }
        case /* Hobbies */ 6:
        {
            key = @"Hobbies";
            break;
        }
        case /* Phone */ 7:
        {
            key = @"Phone Number";
            break;
        }
        case /* Email */ 8:
        {
            key = @"Email";
            break;
        }
        case /* Image */ 9:
        {
            
            break;
        }
    }
    
    ++dataSent;
    
    message = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    NSLog(@"Sent - %@", message);
    
    //  Convert text to NSData
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    //  Send data to connected peers
    NSError *error;
    [self.mySession sendData:data toPeers:[self.mySession connectedPeers] withMode:MCSessionSendDataUnreliable error:&error];
}

- (void) receiveMessage: (NSString *) message fromPeer: (MCPeerID *) peer{
    
    switch( dataRecieved )
    {
        case /* Name */ 0:
        {
            self.personsName = message;
            break;
        }
        case /* Age */ 1:
        {
            self.personsAge = message;
            break;
        }
        case /* HomeTown */ 2:
        {
            self.personsHomeTown = message;
            break;
        }
        case /* Current */ 3:
        {
            self.personsCurrent = message;
            break;
        }
        case /* Education */ 4:
        {
            self.personsEducation = message;
            break;
        }
        case /* Work */ 5:
        {
            self.personsWork = message;
            break;
        }
        case /* Hobbies */ 6:
        {
            self.personsHobbies = message;
            break;
        }
        case /* Phone */ 7:
        {
            self.personsPhone = message;
            break;
        }
        case /* Email */ 8:
        {
            self.personsEmail = message;
            // Done
            
            if( dataSent >= 8 )
            {
                [self personsDataGathered];
            }
            else
            {
                [self sendMessages];
            }
            break;
        }
        case /* Image */ 9:
        {
            
            break;
        }
    }
    ++dataRecieved;
    
    NSLog(@"Recieved - %@", message);
    
}

#pragma marks MCBrowserViewControllerDelegate

// Notifies the delegate, when the user taps the done button
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self dismissBrowserVC];
    
    [self sendMessages];
}

// Notifies delegate that the user taps the cancel button.
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self dismissBrowserVC];
}

// Prepare to transfer data to another viewport
- (void) personsDataGathered {
    [self performSegueWithIdentifier: @"transitionToFacial" sender: self];
}

// Seque is being performed - Transfer all data
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"transitionToFacial"])
    {
        FacialViewController *controller = (FacialViewController *)segue.destinationViewController;
        controller.personsImage = self.personsImage;
        controller.personsName = self.personsName;
        controller.personsAge = self.personsAge;
        controller.personsHomeTown = self.personsHomeTown;
        controller.personsCurrent = self.personsCurrent;
        controller.personsEducation = self.personsEducation;
        controller.personsWork = self.personsWork;
        controller.personsHobbies = self.personsHobbies;
        controller.personsPhone = self.personsPhone;
        controller.personsEmail = self.personsEmail;
    }
}





#pragma marks MCSessionDelegate
// Remote peer changed state
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

// Received data from remote peer
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    //  Decode data back to NSString
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //  append message to text box:
    dispatch_async(dispatch_get_main_queue(), ^{
        [self receiveMessage:message fromPeer:peerID];
    });
}

// Received a byte stream from remote peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

// Start receiving a resource from remote peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}

// Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}

//| ----------------------------------------------------------------------------
//  IBAction for tapping the button in this demo.
//
- (IBAction)buttonAction:(id)sender
{
    // Reset the buttons bounds to their initial state.  See the comment in
    // -viewDidLoad.
    self.finderButton.bounds = self.button1Bounds;
    
    // UIDynamicAnimator instances are relatively cheap to create.
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // APLPositionToBoundsMapping maps the center of an id<ResizableDynamicItem>
    // (UIDynamicItem with mutable bounds) to its bounds.  As dynamics modifies
    // the center.x, the changes are forwarded to the bounds.size.width.
    // Similarly, as dynamics modifies the center.y, the changes are forwarded
    // to bounds.size.height.
    APLPositionToBoundsMapping *buttonBoundsDynamicItem = [[APLPositionToBoundsMapping alloc] initWithTarget:sender];
    
    // Create an attachment between the buttonBoundsDynamicItem and the initial
    // value of the button's bounds.
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:buttonBoundsDynamicItem attachedToAnchor:buttonBoundsDynamicItem.center];
    [attachmentBehavior setFrequency:2.0];
    [attachmentBehavior setDamping:0.3];
    [animator addBehavior:attachmentBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[buttonBoundsDynamicItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.angle = M_PI_4;
    pushBehavior.magnitude = 15.0;
    [animator addBehavior:pushBehavior];
    
    [pushBehavior setActive:TRUE];
    
    self.animator = animator;
}

@end
