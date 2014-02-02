//
//  TutorialViewController.m
//  glimpse
//
//  Created by Student on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@end

@implementation TutorialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.navigationItem.title = @"Tutorial";
    //Create the data model
    _pageTitles = @[@"Create Your Profile", @"Find Nearby People", @"Pick a Suitable Person to Meet", @"Find That Person", @"Add Their Contact"];
    _pageImages = @[@"bg", @"bg2", @"bg3", @"bg4", @"bg5"];
    //Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    self.pageViewController.dataSource = self;
    
    TutorialContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.title = @"Tutorial";
}

- (TutorialContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count]))
    {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    TutorialContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
    {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
