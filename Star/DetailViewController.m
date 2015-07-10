//
//  DetailViewController.m
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//
#import "DetailViewController.h"

@interface DetailViewController ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0.0, -320.f, 320.f, 320.f)];
    [self.view addSubview:self.imageView];
    self.imageView.image=self.photo.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
    [self.view setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  //  UIAttachmentBehavior *att = [[UIAttachmentBehavior alloc] initWithItem:self.imageView attachedToAnchor:CGPointMake(169, 0)];
    UISnapBehavior *snap  =[[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:self.view.center];
    [self.animator addBehavior:snap];
    
}
-(void) close{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end