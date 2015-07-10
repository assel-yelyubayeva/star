//
//  MySignUpViewController.m
//  The star
//
//  Created by Assel Yelyubayeva on 07.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//
#import "MySignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "BrowseViewController.h"
#import <ParseUI/ParseUI.h>

@interface MySignUpViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic) UIColor *mainColor ;
@property (nonatomic) NSString *userType;
@property (nonatomic) UIImageView *avatar;
@end

@implementation MySignUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.userType=@"producer";
    self.mainColor=[UIColor colorWithRed:0.243f green:0.149f blue:0.3921 alpha:1.0];
    [self setupMainControls];
    [self setupSegmentedControl];
    [self setupImageView];
    
}
-(void) setupMainControls{
    [self.signUpView setLogo:nil];
    [self.signUpView setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.signUpButton setBackgroundColor:self.mainColor];
    [self.signUpView.signUpButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    self.signUpView.signUpButton.layer.cornerRadius=5;
    self.signUpView.signUpButton.clipsToBounds=YES;
    [self.signUpView.signUpButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [[self.signUpView.signUpButton titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    self.signUpView.additionalField.placeholder=@"Full name";
    [self.signUpView.signUpButton removeTarget: nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.signUpView.signUpButton addTarget:self
                                     action:@selector(signUpAction:)
                           forControlEvents:UIControlEventTouchUpInside];
}
-(void) setupSegmentedControl{
    NSArray *itemArray = [NSArray arrayWithObjects: @"Producer", @"Talent", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [segmentedControl setFrame: CGRectMake(35, 100, 300, 50)];
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor=self.mainColor;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [segmentedControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    [self.signUpView addSubview:segmentedControl];
}
-(void) setupImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photoplaceholder.png"]];
    [imageView setFrame:CGRectMake(145, 80, 80, 80)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    imageView.clipsToBounds = YES;
    [imageView.layer setBorderColor:self.mainColor.CGColor];
    [imageView.layer setBorderWidth:1.0];
    imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
    singleTap.numberOfTapsRequired=1;
    [imageView addGestureRecognizer:singleTap];
    self.avatar=imageView;
    [self.signUpView addSubview:self.avatar];
}
-(void) selectImage:(id) sender{
    NSLog(@"tapped");
}
- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.avatar.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
       self.userType=@"producer";
    }else{
        self.userType=@"talent";
    }
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.signUpView.signUpButton setFrame:CGRectMake(35.0f, 360.0f, 300.0f, 40.0f)];
    [self.signUpView.usernameField setFrame:CGRectMake(35.0f, 220.0f, 300.0f, 40.0f)];
    [self.signUpView.passwordField setFrame:CGRectMake(35.0f, 260.0f, 300.0f, 40.0f)];
    [self.signUpView.emailField setFrame:CGRectMake(35.0f, 300.0f, 300.0f, 40.0f)];
    [self.signUpView.additionalField setFrame:CGRectMake(35.0f, 180.0f, 300.0f, 40.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)signUpAction:(id)sender 	{

    NSString *username = self.signUpView.usernameField.text;
    NSString *password = self.signUpView.passwordField.text;
    NSString *email = self.signUpView.emailField.text;
    NSString *fullName = self.signUpView.additionalField.text;
    
    
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    
    if (email) {
        user.email = email;
    }
    if (fullName) {
        user[@"fullName"] = fullName;
    }
    user[@"type"]=self.userType;
    if ([username length] == 0 || [email length] == 0 || [password length] == 0 || fullName.length==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you fill in all the fields!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }else{
        [self setLoading:YES];

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self setLoading:NO];
       
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertView show];
            }
            else {

                [self launchWelcome];
            }
        }];
    }
}
- (void)setLoading:(BOOL)loading {

        self.signUpView.usernameField.enabled = !loading;
        self.signUpView.passwordField.enabled = !loading;
        self.signUpView.emailField.enabled = !loading;
        self.signUpView.additionalField.enabled = !loading;
        self.signUpView.dismissButton.enabled = !loading;
        if(loading){
            if (!self.activityIndicatorView) {
                self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            }
            [self.activityIndicatorView startAnimating];
            CGFloat activityIndicatorRightInset = 12.0f;
            
            CGRect activityIndicatorFrame = MakeWithSizeCenteredInRect(self.activityIndicatorView.bounds.size, self.signUpView.signUpButton.bounds);
            activityIndicatorFrame.origin.x = (CGRectGetMinX(self.signUpView.signUpButton.titleLabel.frame)
                                               - CGRectGetWidth(activityIndicatorFrame)
                                               - activityIndicatorRightInset);
            _activityIndicatorView.frame = activityIndicatorFrame;
            [self.signUpView.signUpButton addSubview:_activityIndicatorView];
            [self.signUpView.signUpButton setNeedsLayout];
        } else {
            [self.activityIndicatorView stopAnimating];
            [self.activityIndicatorView removeFromSuperview];
        }
}
CGRect MakeWithSizeCenteredInRect(CGSize size, CGRect rect) {
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGPoint origin = CGPointMake(floorf(center.x - size.width / 2.0f),
                                 floorf(center.y - size.height / 2.0f));
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

-(void) launchWelcome{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BrowseViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Browse"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end