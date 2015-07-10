//
//  InitialScreenViewController.m
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "InitialScreenViewController.h"
#import "PageContentViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
#import "BrowseViewController.h"
@interface InitialScreenViewController ()

@end

@implementation InitialScreenViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        //self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        //self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text=@"Swipe to know more";
    self.signInButton.layer.cornerRadius=5;
    self.signInButton.clipsToBounds=YES;
    [self.signInButton.titleLabel  setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [self.signUpButton.titleLabel  setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    
    _pageTitles = @[@"iStar", @"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    _pageImages = @[@"logovertical.png", @"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    // Do any additional setup after loading the view.
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated..
}
#pragma mark - Page Controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {

        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    if(index==0){
        self.label.text=@"Swipe to know more";
    }else{
        self.label.text=@"";
    }
    return pageContentViewController;
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
#pragma mark - IBAction
- (IBAction)signInButtonPressed:(UIButton *)sender {
    MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
    logInViewController.delegate = self;
    logInViewController.facebookPermissions = @[@"friends_about_me"];
    logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsDismissButton | PFLogInFieldsLogInButton |PFLogInFieldsPasswordForgotten;//| PFLogInFieldsFacebook 
  
    [self presentViewController:logInViewController animated:YES completion:NULL];
}
- (IBAction)signUpButtonPressed:(UIButton *)sender {
    MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    signUpViewController.fields=PFSignUpFieldsEmail|PFSignUpFieldsUsernameAndPassword|PFSignUpFieldsAdditional|PFSignUpFieldsSignUpButton|PFSignUpFieldsDismissButton;
    [self presentViewController:signUpViewController animated:YES completion:NULL];
}

#pragma mark - LogIn
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self launchWelcome];
}
-(void) launchWelcome{
    BrowseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Browse"];
    UIViewController *svc = [self topMostController];
    [svc presentViewController:vc animated:YES completion:nil];
}
// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}
- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

#pragma mark - SignUp

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
