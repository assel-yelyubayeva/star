//
//  ViewController.h
//  The star
//
//  Created by Assel Yelyubayeva on 02.07.15.
//  Copyright (c) 2015 Assel Yelyubayeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Talent.h"
@interface TalentProfileViewController : UIViewController
@property (nonatomic) Talent *talent;
@property (nonatomic) NSString *userID;
@end

