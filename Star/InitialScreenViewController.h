//
//  InitialScreenViewController.h
//  The star
//
//  Created by Assel Yelyubayeva on 06.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import <ParseUI/ParseUI.h>
@interface InitialScreenViewController : UIViewController<UIPageViewControllerDataSource, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@end
