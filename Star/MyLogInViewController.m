//
//  MyLoginViewController.m
//  The star
//
//  Created by Assel Yelyubayeva on 07.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import "MyLogInViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@property (nonatomic) UIColor *mainColor;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainColor =[UIColor colorWithRed:0.243f green:0.149f blue:0.3921 alpha:1.0];
    [self.logInView setLogo:nil];
    [self.logInView setBackgroundColor:[UIColor whiteColor]];
    [self.logInView.logInButton setBackgroundColor:self.mainColor];
    [self.logInView.passwordForgottenButton setBackgroundColor:[UIColor clearColor]];
    [self.logInView.logInButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.logInView.logInButton setBackgroundImage:nil forState:UIControlStateHighlighted];
    self.logInView.logInButton.layer.cornerRadius=5;
    self.logInView.logInButton.clipsToBounds=YES;
    self.logInView.facebookButton.layer.cornerRadius=5;
    self.logInView.facebookButton.clipsToBounds=YES;
    [self.logInView.logInButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [self.logInView.passwordForgottenButton setTitleColor: self.mainColor forState:UIControlStateNormal];
    [[self.logInView.logInButton titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [[self.logInView.passwordForgottenButton titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    //[self drawLine];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.logInView.facebookButton setFrame:CGRectMake(35.0f, 340.0f, 300.0f, 40.0f)];
    [self.logInView.logInButton setFrame:CGRectMake(35.0f, 220.0f, 145.0f, 40.0f)];
    [self.logInView.passwordForgottenButton setFrame:CGRectMake(190.0f, 220.0f, 145.0f, 40.0f)];
    [self.logInView.usernameField setFrame:CGRectMake(35.0f, 110.0f, 300.0f, 40.0f)];
    [self.logInView.passwordField setFrame:CGRectMake(35.0f, 150.0f, 300.0f, 40.0f)];
    
}
-(void) drawLine{
    UILabel *label = [[UILabel alloc] init];
    label.text=@"Or";
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=self.mainColor;
    [label setFrame: CGRectMake(35.0f, 280.0f, 300.0f, 40.0f)];
    [self.logInView addSubview:label];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(35.0, 300.0)];
    [path addLineToPoint:CGPointMake(155.0, 300.0)];
    [path moveToPoint:CGPointMake(215.0, 300.0)];
    [path addLineToPoint:CGPointMake(335.0, 300.0)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:0.243f green:0.149f blue:0.3921 alpha:0.5] CGColor];
    shapeLayer.lineWidth = 0.5;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.view.layer addSublayer:shapeLayer];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
